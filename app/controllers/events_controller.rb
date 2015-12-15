class EventsController < ApplicationController
  include NylasHelper
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :event_drag]
  before_action :set_user, :set_firm

  #around_filter :user_time_zone, if: :current_user

  helper DatesHelper

  # GET /events
  # GET /events.json
  def index
    prepare_event_sources

    # for populating the auto_complete dropdown
    # TODO: need to think how to NOT call it twice (since it is being called in refresh_events as well)
    # @emails_autocomplete = emails_autocomplete
    @new_path = new_event_path
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    restrict_access('events') if @event.firm != current_user.firm
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    restrict_access('events') if @event.firm != current_user.firm
    @model = @event
     
    @updated_minus_created_ms = (@event.updated_at - @event.created_at).to_f

    #puts ">>>>>>>>>>>>>>>>>>>Event UPDATED AT " + @event.updated_at.to_f.to_s + "    MINUS   " + @event.created_at.to_f.to_s + " EQUALS " + @updated_minus_created_ms.to_s

    # @emails_autocomplete = emails_autocomplete
    if @event.calendar
      if !@event.read_only && (current_user == @event.calendar.user || current_user.edit_event_allowed?)
        render partial: 'events/edit'
      else
        render partial: 'events/show'
      end
    else
      render partial: 'events/edit'
    end
  end

  # POST /events
  # POST /events.json
  def create
    calendar = Calendar.find(event_params[:calendar_id]) if event_params[:calendar_id].present?
    calendar ||= nil

    attrs = prepare_event_attr.merge({
                                         created_by: @user.id,
                                         owner_id: calendar ? calendar.namespace.user_id : @user.id,
                                         firm_id: @firm.id
                                     })

    if event_params[:recur]
      event = EventSeries.new(attrs.merge({
                                               period: event_params[:period],
                                               frequency: event_params[:frequency],
                                               recur_start_date: parse_query_date(:recur_start_date),
                                               recur_end_date: parse_query_date(:recur_end_date),
                                               user_id: @user.id
                                           }))
    else
      event = Event.new(attrs)
    end

    if event.save
      begin
        event.assign_participants(event_params[:participants], @firm.id) if event_params[:participants].present?
        event.create_process calendar, calendar.namespace.nylas_inbox, @firm.id unless calendar.blank?
      rescue Exception => e
        Rails.logger.fatal "Error while create event\n - Time: #{Time.now}\n  - Message:#{e.message}\n - Backtrace: #{e.backtrace.join("\n")}"
      end
    end

    message = event.errors.present? ? {error: event.errors.full_messages.to_sentence} : {notice: 'Event was successfully created.'}
    respond_to do |format|
      format.html { redirect_to request.referrer, :flash => message }
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    begin
      @event.make_update event_params, prepare_event_attr, @firm.id
    rescue Exception => e
      Rails.logger.fatal "Error while update event\n - Time: #{Time.now}\n  - Message:#{e.message}\n - Backtrace: #{e.backtrace.join("\n")}"
    end

    message = @event.errors.blank? ? {notice: 'Event was successfully updated.'} : {error: @event.errors.full_messages.to_sentence}
    respond_to do |format|
      format.html { redirect_to request.referrer, :flash => message }
    end
  end

  def event_drag
    if @event && @event.drag_update(event_drag_params, @user.id)
      message = @event.errors.present? ? @event.errors.full_messages.to_sentence : 'Event was successfully updated.'
      render :json => {success: true, message: message}
    else
      render :json => "Event isn't found", status: 404
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if params[:delete_all] == 'true' && @event.event_series.present?
      @event.destroy_series
    else
      @event.nylas_destroy
    end
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def emails_autocomplete
    users_emails = (Soulmate::Matcher.new("contact-#{@firm.id}").matches_for_term(params[:term], {:limit => 30})).map {|match| match['term'] }
    puts "USER EMAILS ------------------------------------------> " + users_emails.inspect
    render json: users_emails.uniq.compact
  end

  def refresh_events
    events_synced = 0

    updated_events_hash = {}

    new_events = 0
    updated_events = 0
    updating_events = 0
    errors_count = 0
    errors = []

    @user.sync_namespace(@firm, errors, errors_count, events_synced, updated_events_hash, updating_events, new_events, updated_events)

    message = "#{events_synced} events were synced."

    Rails.logger.fatal "Sync events result for user: #{@user.email}\nTime: #{Time.now}\nCreated events: #{new_events}\nUpdated events: #{updated_events}\nUpdating events: #{updating_events}\nTotal: #{events_synced}"

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: message }
      format.json {
        prepare_event_sources
        render json: {events: @event_sources, events_synced: events_synced, message: message}
      }
    end
  end

  def get_user_events
    #user = User.find(params[:user_id])
    @events = @user.events
    events_list = @events.select([:id, :subject, :start, :end, :all_day]).map { |e| e.to_json_hash }
    respond_to do |format|
      format.json { render json: {events: events_list} }
    end
  end

  private

  def prepare_event_sources
    @users ||= @firm.users

    compact_events = @firm.events.includes(:owner).map do |event|
      user = event.owner
      user.disabled? ? nil : event.to_json_hash.merge(user.hash_for_event(event, @users))
    end
    compact_events.compact!

    @event_sources = compact_events.group_by { |d| d[:user_id] } || {}
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :location, :description, :calendar_id, :summary, :start_date, :start_time, :case_id, :lead_id,
                                  :end_date, :end_time, :all_day, :status, :participants, :recur, :period, :frequency, :is_reminder,
                                  :recur_start_date, :recur_end_date, :event_series_id, :update_all_events, :last_updated_by)
  end

  def event_drag_params
    params.require(:event).permit(:starts_at, :ends_at, :last_updated_by)
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def parse_query_date(date)
    EventDateConverter.parse_query_date event_params[date]
  end

  def convert_query_date(date)
    EventDateConverter.convert_query_date event_params[date]
  end

  def convert_query_time(date, time)
    EventDateConverter.convert_query_time event_params[date], event_params[time]
  end

  # def

  def prepare_event_attr
    {
        title: event_params[:title],
        description: event_params[:description],
        location: event_params[:location],
        starts_at: event_params[:all_day] ? convert_query_date(:start_date) : convert_query_time(:start_date, :start_time),
        ends_at: event_params[:all_day] ? convert_query_date(:end_date) : convert_query_time(:end_date, :end_time),
        all_day: event_params[:all_day],
        last_updated_by: @user.id,
        case_id: event_params[:case_id],
        is_reminder: event_params[:is_reminder],
        calendar_id: event_params[:calendar_id],
        lead_id: event_params[:lead_id]
    }
  end

end
