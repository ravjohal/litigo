class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :update_last_sign_in_at
  after_action :verify_authorized, except: [:show,:save_google_oauth]
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'
  require 'icalendar'

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])

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
    @auth = request.env["omniauth.auth"]
    @token = @auth["credentials"]["token"]
    current_user.oauth_token = @token
    current_user.oauth_expires_at = DateTime.strptime(@auth['credentials']['expires_at'].to_s,'%s')
    current_user.google_email = @auth['info']['email']
    current_user.save

    client = Google::APIClient.new
    client.authorization.access_token = @token
    #getting google calendar events
    calendar = client.discovered_api('calendar', 'v3')
    @google_calendar = client.execute(
        :api_method => calendar.events.list,
        :parameters => {'calendarId' => 'primary'},
        :headers => {'Content-Type' => 'application/json'})
    logger.info "@google_calendar1: #{@google_calendar.data.items}\n\n\n"
    while true
      events = @google_calendar.data.items
      events.each do |e|
        #TODO save needed info from google calendar events
        print e.summary + "\n"
      end
      if !(page_token = @google_calendar.data.next_page_token)
        break
      end
      @google_calendar = client.execute(:api_method => calendar.events.list,
                              :parameters => {'calendarId' => 'primary',
                                              'pageToken' => page_token})
    end
    #getting google contacts
    contacts = RestClient.get("https://www.google.com/m8/feeds/contacts/#{current_user.google_email}/full?alt=json&max-results=99999",
                                      {:content_type => :json, :authorization => "Bearer #{current_user.oauth_token}"})
    jsonObj = JSON.parse contacts
    jsonObj['feed']['entry'].each do |e|
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
      logger.info "new_contact: #{new_contact.inspect}\n\n\n"
      #TODO Save properly contacts with connection to User
      # new_contact.save
      #binding.pry
    end
    redirect_to user_path(current_user.id)
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
    params.require(:user).permit(:role, :event_ids => [])
  end

end
