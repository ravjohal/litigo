class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'

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
        format.html { redirect_to request.referrer, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    event_params_google = params[:event]
      google_event = Hash.new{|h,k| h[k] = {} }
    google_event = {
        status: event_params_google[:status],
        summary: event_params_google[:summary],
        start: {},
        end: {}
    }
      if @event.all_day
        google_event[:start][:date] = event_params[:start].to_date
        google_event[:end][:date] = event_params[:end].to_date
      else
        google_event[:start][:dateTime] = event_params[:start].to_datetime
        google_event[:end][:dateTime] = event_params[:end].to_datetime
      end
      client = init_client
      calendar = client.discovered_api('calendar', 'v3')
      update_google_event = client.execute(
          :api_method => calendar.events.patch,
          :parameters => {'calendarId' => @event.google_calendar_id, 'eventId' => @event.google_id},
          :body_object => google_event,
          :headers => {'Content-Type' => 'application/json'})
    logger.info "update_google_event: #{update_google_event.ai}\n\n\n"

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to request.referrer, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
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
    params.require(:event).permit(:subject, :location, :date, :time, :all_day, :reminder, :notes, :owner_id, :summary, :start, :end, :status, :user_ids => [], :case_ids => [], :contact_ids => [], :event_attendee_ids => [])
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

end
