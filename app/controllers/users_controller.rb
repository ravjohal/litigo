class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:save_google_oauth]
  before_filter :update_last_sign_in_at
  after_action :verify_authorized, except: [:show,:save_google_oauth, :select_calendar]
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    if params[:google_auth]
      @calendars = @user.google_calendars
    end
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def start_google_oauth
    @user = User.find(params[:id])
  end

  def save_google_oauth
    create_google_oauth
    client = init_client
    calendar = client.discovered_api('calendar', 'v3')
    page_token = nil
    result = client.execute(:api_method => calendar.calendar_list.list)
    while true
      entries = result.data.items
      entries.each do |e|
        google_calendar = GoogleCalendar.find_or_initialize_by(google_id: e['id'])
        next if google_calendar.etag.present? && google_calendar.etag == e['etag']
        google_calendar.user_id = current_user.id
        google_calendar.firm_id = current_user.firm_id
        google_calendar.google_id = e['id']
        google_calendar.etag = e['etag']
        google_calendar.summary = e['summary']
        google_calendar.description = e['description']
        google_calendar.timeZone = e['timeZone']
        google_calendar.selected = e['selected']
        google_calendar.primary = e['primary']
        google_calendar.save

      end
      if !(page_token = result.data.next_page_token)
        break
      end
    end
    @calendars = []
    GoogleCalendar.all.each do |cal|
      @calendars.push({id: cal.google_id, summary: cal.summary})
    end
    #getting google contacts
    contacts = RestClient.get("https://www.google.com/m8/feeds/contacts/#{current_user.google_email}/full?alt=json&max-results=99999",
                                      {:content_type => :json, :authorization => "Bearer #{current_user.oauth_token}"})
    jsonObj = JSON.parse contacts
    jsonObj['feed']['entry'].each do |e|
      logger.info "contact: #{e}\n\n"
      contact_email = e['gd$email'][0]['address'] if e['gd$email']
      if contact_email.nil? or contact_email.empty?
        next
      end
      contact_name = e['title']['$t'] if e['title']
      if contact_name.nil? or contact_name.empty?
        next
      end
      name_list = contact_name.split(' ',2)
      first_name = name_list[0]
      last_name = 'Unknown'
      if name_list.length > 1
        last_name = name_list[1]
      end
      new_contact = Contact.new(
          :email => contact_email,
          :first_name => first_name,
          :last_name => last_name,
          :type => "General")
      # logger.info "new_contact: #{new_contact.inspect}\n\n\n"
      #TODO Save properly contacts with connection to User
      new_contact.save
      #binding.pry
    end
    # render json: @calendars.to_json
    redirect_to user_path({id: current_user.id, google_auth: true})
  end

  def select_calendar
    client = init_client
    calendar = client.discovered_api('calendar', 'v3')
    if params[:select_calendar].present?
      params[:select_calendar].each do |key, val|
        if val == '1'
          @google_calendar = client.execute(
              :api_method => calendar.events.list,
              :parameters => {'calendarId' => key.to_s},
              :headers => {'Content-Type' => 'application/json'})
          while true
            events = @google_calendar.data.items
            events.each do |e|
              google_event = Event.find_or_initialize_by(google_id: e['id'])
              next if google_event.etag.present? && google_event.etag == e['etag']

              google_event.etag = e['etag']
              google_event.google_calendar_id = key.to_s
              google_event.google_id = e['id']
              google_event.status = e['status']
              google_event.htmlLink = e['htmlLink']
              google_event.summary = e['summary']
              google_event.all_day = !e['start']['dateTime'].present?
              google_event.start = e['start']['dateTime'].present? ? e['start']['dateTime'] : e['start']['date']
              google_event.end = e['end']['dateTime'].present? ? e['end']['dateTime'] : e['end']['date']
              google_event.endTimeUnspecified = e['endTimeUnspecified']
              google_event.transparency = e['transparency']
              google_event.visibility = e['visibility']
              google_event.location = e['location']
              google_event.iCalUID = e['iCalUID']
              google_event.sequence = e['sequence']
              google_event.owner_id = current_user.id
              google_event.firm_id = current_user.firm.id
              google_event.save!
              creator = EventAttendee.find_or_initialize_by(email: e['creator']['email'], event_id: google_event.id)
              creator.event_id = google_event.id
              creator.display_name = e['creator']['displayName']
              creator.email = e['creator']['email']
              creator.creator = true
              creator.save!

              e['attendees'].each do |attrs|
                if attrs['email'] != creator.email
                  attendee = EventAttendee.find_or_initialize_by(email: e['creator']['email'], event_id: google_event.id)
                  attendee.event_id = google_event.id
                  attendee.display_name = attrs['displayName']
                  attendee.email = attrs['email']
                  attendee.response_status = attrs['responseStatus']
                  attendee.save!
                end
              end
            end
            if !(page_token = @google_calendar.data.next_page_token)
              break
            end
          end
        end

      end
    end
    render :nothing => true, :status => 200
  end

  def invite_user
    @user = User.invite!(:email => params[:user][:email], :name => params[:user][:name])
    render :json => @user
  end

  protected

  def update_last_sign_in_at
    if user_signed_in? && !session[:logged_signin]
      sign_in(current_user, :force => true)
      session[:logged_signin] = true
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role, :time_zone, :event_ids => [])
  end

  def create_google_oauth
    @auth = request.env["omniauth.auth"]
    @token = @auth["credentials"]["token"]
    @refresh_token = @auth["credentials"]["refresh_token"]
    @expires_at = DateTime.strptime(@auth['credentials']['expires_at'].to_s,'%s')
    logger.info "@auth: #{request.env["omniauth.auth"]["credentials"]}\n\n\n"
    logger.info "@refresh_token: #{@refresh_token.ai}\n\n\n"
    current_user.oauth_token = @token
    current_user.oauth_refresh_token = @refresh_token
    current_user.oauth_expires_at = @expires_at
    current_user.google_email = @auth['info']['email']
    current_user.save
  end

  def init_client
    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    client.authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
    client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
    client.authorization.refresh_token = current_user.oauth_refresh_token
    return client
  end
end
