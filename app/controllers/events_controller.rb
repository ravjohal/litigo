class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'

  around_filter :user_time_zone, if: :current_user

  # GET /events
  # GET /events.json
  def index
    @events = []
    @events = @user.firm.events if @user.firm
    @events_list = []
    @events.each do |event|
      hash = {}
      hash[:id] = event.id
      hash[:title] = event.summary
      hash[:start] = event.all_day ? "#{event.start.to_date}" : "#{event.start.to_datetime}"
      hash[:end] = event.all_day ? "#{event.end.to_date-1.day}" : "#{event.end.to_datetime}"
      hash[:allDay] = event.all_day
      @events_list << hash
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    
  end

  # GET /events/new
  def new
    @event = Event.new

  end

  # GET /events/1/edit
  def edit
    @event.start = @event.start.to_datetime
    @event.end = @event.end.to_datetime
    if @event.owner_id == current_user.id
      render partial: 'events/edit'
    else
      render partial: 'events/show'
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    @event.owner = @user
    @event.firm = @firm

    respond_to do |format|
      if @event.save
        google_attendees = []
        @event.event_attendees.each do |attendee|
          google_attendees << {email: attendee.contact.email,
                               displayName: attendee.display_name.present? ? attendee.display_name : "#{attendee.contact.first_name} #{attendee.contact.last_name}"}
        end
        google_event = {
            status: @event.status,
            summary: @event.summary,
            location: @event.location,
            start: {},
            end: {},
            attendees: google_attendees
        }
        if @event.all_day
          google_event[:start][:date] = @event.start.to_date
          google_event[:end][:date] = @event.end.to_date
        else
          google_event[:start][:dateTime] = @event.start.to_datetime
          google_event[:end][:dateTime] = @event.end.to_datetime
        end
        client = init_client
        calendar = client.discovered_api('calendar', 'v3')
        create_google_event = client.execute(
            :api_method => calendar.events.insert,
            :parameters => {'calendarId' => @event.google_calendar_id},
            :body_object => google_event,
            :headers => {'Content-Type' => 'application/json'})
        if create_google_event.response.status.to_i == 200
          response = JSON.parse(create_google_event.response.env[:body])
          @event.update({
              etag: response['etag'],
              google_id: response['id'],
              htmlLink: response['htmlLink'],
              iCalUID: response['iCalUID'],
              endTimeUnspecified: response['endTimeUnspecified'],
              transparency: response['transparency'],
              visibility: response['visibility'],
              sequence: response['sequence']
                        })
        end
        format.html { redirect_to request.referrer, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { redirect_to request.referrer, notice: @event.errors.full_messages.to_sentence}
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        google_attendees = []
        @event.event_attendees.each do |attendee|
          google_attendees << {email: attendee.contact.email,
                               displayName: attendee.display_name.present? ? attendee.display_name : "#{attendee.contact.first_name} #{attendee.contact.last_name}"}
        end
        google_event = {
            status: @event.status,
            summary: @event.summary,
            location: @event.location,
            start: {},
            end: {},
            attendees: google_attendees
        }
        if @event.all_day
          google_event[:start][:date] = @event.start.to_date
          google_event[:end][:date] = @event.end.to_date
        else
          google_event[:start][:dateTime] = @event.start.to_datetime
          google_event[:end][:dateTime] = @event.end.to_datetime
        end
        client = init_client
        calendar = client.discovered_api('calendar', 'v3')
        update_google_event = client.execute(
            :api_method => calendar.events.patch,
            :parameters => {'calendarId' => @event.google_calendar_id, 'eventId' => @event.google_id},
            :body_object => google_event,
            :headers => {'Content-Type' => 'application/json'})
        if update_google_event.response.status.to_i == 200
          response = JSON.parse(update_google_event.response.env[:body])
          @event.update({
                            etag: response['etag'],
                            google_id: response['id'],
                            htmlLink: response['htmlLink'],
                            iCalUID: response['iCalUID'],
                            endTimeUnspecified: response['endTimeUnspecified'],
                            transparency: response['transparency'],
                            visibility: response['visibility'],
                            sequence: response['sequence']
                        })
        end
        format.html { redirect_to request.referrer, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { redirect_to request.referrer, notice: @event.errors.full_messages.to_sentence}
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:subject, :location, :date, :time, :all_day, :reminder, :notes, :owner_id, :summary,
                                  :google_calendar_id, :start, :end, :status, :user_ids => [], :case_ids => [],
                                  :contact_ids => [], :event_attendee_ids => [])
  end

  def init_client
    client = Google::APIClient.new(:application_name => "Litigo",
                                   :application_version => "1.0")
    fresh_token
    client.authorization.access_token = current_user.oauth_token
    client.authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
    client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
    client.authorization.refresh_token = current_user.oauth_refresh_token

    return client
  end

  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, {'refresh_token' => current_user.oauth_refresh_token,
                              'client_id' => ENV['GOOGLE_CLIENT_ID'],
                              'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
                              'grant_type' => 'refresh_token'})
  end

  def refresh!
    response = request_token_from_google
    data = JSON.parse(response.body)
    current_user.oauth_token = data['access_token']
    current_user.oauth_expires_at = Time.now + (data['expires_in'].to_i).seconds
    current_user.save!
  end

  def expired?
    current_user.oauth_expires_at < Time.now
  end

  def fresh_token
    refresh! if expired?
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

end
