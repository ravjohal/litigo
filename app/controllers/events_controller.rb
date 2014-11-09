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
    @events = @user.firm.events.where(owner_id: @user.id)
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
    @firm = @user.firm
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
    @event = Event.new(event_params.except!('contacts'))
    @event.owner = @user
    @event.firm = @firm
    @event.save
    attendee_emails = params[:event][:contacts].split(",") if params[:event][:contacts].present?
    if attendee_emails.present?
      attendee_emails.each do |attendee_email|
        contact = Contact.find_or_create_by(email: attendee_email)
        event_attendee = EventAttendee.create({event_id: @event.id, creator: true, contact_id: contact.id})
      end
    end

    GoogleCalendars.create_event(@user, @event)
    message = @event.errors.present? ? {error: @event.errors.full_messages.to_sentence} : {notice: 'Event was successfully created.'}
    respond_to do |format|
      format.html {redirect_to request.referrer , :flash => message}
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    attendee_emails = params[:event][:contacts].split(",") if params[:event][:contacts].present?
    if @event.update(event_params.except!('contacts')) && attendee_emails.present?
      attendee_emails.each do |email|
        contact = Contact.find_or_create_by(email: email)
        event_attendee = EventAttendee.find_or_create_by({event_id: @event.id, creator: true, contact_id: contact.id})
      end
    end
    GoogleCalendars.update_event(@user, @event)
    message = @event.errors.present? ? {error: @event.errors.full_messages.to_sentence} : {notice: 'Event was successfully updated.'}
    respond_to do |format|
      format.html {redirect_to request.referrer , :flash => message}
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

  def emails_autocomplete
    users_emails = []
    @user.firm.users.map {|user| users_emails << user.email}
    @user.events.map do |event|
      event.contacts.map {|contact| users_emails << contact.email}
    end
    @autocomplete_emails = []
    users_emails.each do |users_email|
      @autocomplete_emails << {label: users_email, value: users_email}
    end
    respond_to do |format|
      format.json {render json: @autocomplete_emails.uniq}
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
                                  :google_calendar_id, :start, :end, :status, :contacts, :user_ids => [], :case_ids => [],
                                  :event_attendee_ids => [])
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
end
