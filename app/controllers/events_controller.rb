class EventsController < ApplicationController
  include NylasHelper
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :event_drag]
  before_action :set_user, :set_firm

  #around_filter :user_time_zone, if: :current_user

  # GET /events
  # GET /events.json
  def index
    prepare_event_sources

    # @users.each_with_index do |user, index|
    #   hash = {user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(index)}

    #@event_sources.each

    # puts "EVENTS GROUPD CALENDAR ***************************************** " + @event_sources.inspect
    # end

    # events_grouped = @firm.events.group_by{|e| [e.user_id, e.calendar_id]}
    # puts "EVENTS GROUPED -------------------------------------------------------> " + events_grouped.inspect
    # events_grouped.each do |user_cal, events|
    #     user = User.find(user_cal.first)
    #     puts "USER --------> " + user.id.to_s
    #     hash = {user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(index)}
    #     events_for_calendar = []
    #     puts "USER_CAL.LAST  " + user_cal.last.to_s + "\n"
    #     if user_cal.last #if there is a calendar assoicated with this user
    #       calendar = Calendar.find(user_cal.last) 
    #       puts "CALENDARRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR " + calendar.inspect
    #       calendar.events.each do |event|
    #         event = {id: event.id, title: event.title, start: event.starts_at, end: event.ends_at, allDay: event.all_day }
    #         events_for_calendar << event
    #         puts "EVENT ++++++++++++++++++++++++++++++++++++++++++++ " + event.inspect
    #       end  
    #     else
    #       events.each do |event|
    #         event = {id: event.id, title: event.title, start: event.starts_at, end: event.ends_at, allDay: event.all_day }
    #         events_for_calendar << event
    #       end
    #     end

    #     hash[:events] = events_for_calendar
    #     puts "HASH ++++++++++++++++++++++++++++++++++++++++++++ " + hash.inspect
    #     @event_sources[user.id] = hash 
    #     #puts "EVENT SOURCES ++++++++++++++++++++++++++++++++++++++++++++ " + @event_sources.inspect
    #     end

    #events_grouped = @firm.events.group_by(&:user_id)
    #puts " EVENTS GROUPED -----------------------------------------------------------> " + events.inspect
    # events_grouped.each do |user_cal, events|
    #     user = User.find(u_id)
    #     puts "USER --------> " + user.id.to_s
    #     hash = {user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(index)}

    #     events_for_calendar = []
    #     events.each do |event|
    #       event = {id: event.id, title: event.title, start: event.starts_at, end: event.ends_at, allDay: event.all_day }
    #       events_for_calendar << event
    #       #puts "EVENT ++++++++++++++++++++++++++++++++++++++++++++ " + event.inspect
    #     end  

    #     hash[:events] = events_for_calendar
    #     puts "HASH ++++++++++++++++++++++++++++++++++++++++++++ " + hash.inspect
    #     @event_sources[user.id] = hash 
    #     #puts "EVENT SOURCES ++++++++++++++++++++++++++++++++++++++++++++ " + @event_sources.inspect
    #     end
    #     puts "EVENT SOURCES ++++++++++++++++++++++++++++++++++++++++++++ " + @event_sources.inspect
    # @users.each_with_index do |user, index|
    #   hash = {user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(index)}
    #   events = []
    #   user.calendars.each do |calendar| 
    #     #puts "Calendar ------------------------------------------ " + calendar.inspect
    #     calendar.events.each do |event|
    #       event = {id: event.id, title: event.title, start: event.starts_at, end: event.ends_at, allDay: event.all_day }
    #       events << event
    #       #puts "EVENT ++++++++++++++++++++++++++++++++++++++++++++ " + event.inspect
    #     end
    #   end
    #   hash[:events] = events
    #   @event_sources[user.id] = hash
    # end

    #puts "EVENT SOURCES &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& " + @event_sources.inspect
    # @users.each_with_index do |user, index|
    #   hash = {user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(index)}
    #   events = []
    #   if user.calendars
    #     user.events.where(:calendar_id => user.calendars.pluck(:id)).each do |event|
    #       event = {id: event.id, title: event.title, start: event.starts_at, end: event.ends_at, allDay: event.all_day }
    #       events << event
    #     end
    #   end
    #   hash[:events] = events
    #   @event_sources[user.id] = hash
    # end
    @emails_autocomplete = emails_autocomplete
    @new_path = new_event_path
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    restrict_access('events') if @event.user.firm != current_user.firm
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    restrict_access('events') if @event.user.firm != current_user.firm
    @model = @event
    @emails_autocomplete = emails_autocomplete
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

    attrs = prepare_event_attr.merge({created_by: @user.id, owner_id: calendar ? calendar.namespace.user_id : @user.id, firm_id: @firm.id})

    if event_params[:recur]
      event = EventSeries.new(attrs.merge({period: event_params[:period], frequency: event_params[:frequency], recur_start_date: parse_query_date(:recur_start_date), recur_end_date: parse_query_date(:recur_end_date)}))
    else
      event = Event.new(attrs)
    end

    if event.save
      event.assign_participants(event_params[:participants], @firm.id) if event_params[:participants].present?
      event.create_process calendar, calendar.namespace.nylas_namespace, @firm.id unless calendar.blank?
    end

    message = event.errors.present? ? {error: event.errors.full_messages.to_sentence} : {notice: 'Event was successfully created.'}
    respond_to do |format|
      format.html { redirect_to request.referrer, :flash => message }
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event.make_update event_params, prepare_event_attr, @firm.id
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
    users_emails = []

    #TODO: there are two loops (none nested), need to figure out how to combine and get email

    @firm.participants.map { |user| users_emails << user.email unless user.email == @user.email }
    @firm.contacts.map { |user| users_emails << user.email unless user.email == @user.email }
    # @user.firm.users.map {|user| users_emails << user.email unless user.email == @user.email}
    # @user.events.map do |event|
    #   event.participants.map {|participant| users_emails << participant.email unless participant.email == @user.email}
    # end
    #puts "USERS EMAILS +++++++++++++ " + users_emails.inspect

    users_emails.uniq.compact
  end

  def refresh_events
    events_synced = 0
    @firm.namespaces.includes(:calendars).each do |namespace|
      active_calendars = namespace.active_calendars
      if active_calendars.present?
        ns = namespace.nylas_namespace
        cursor = namespace.nylas_cursor
        last_cursor = nil

        ns.deltas(cursor, Namespace::NYLAS_EXCLUDE_DELTA) do |n_event, ne|
          if ne.is_a?(Nylas::Event)
            if n_event == 'create' or n_event == 'modify'
              calendar = active_calendars.find_by(calendar_id: ne.calendar_id)
              if calendar.present?
                event = Event.find_or_initialize_by(nylas_event_id: ne.id)
                if ne.status == 'cancelled'
                  event.destroy
                else
                  event.assign_nylas_while_refresh ne, @firm, calendar, namespace
                end
              end
            end
            events_synced += 1
            last_cursor = ne.cursor
          end
        end
        namespace.update(cursor: last_cursor) if last_cursor.present?
      end
    end
    message = "#{events_synced} events were synced."

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
      event.to_json_hash.merge({ user_id: user.id, user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(@users.to_a.index(user)) })
    end

    @event_sources = compact_events.group_by { |d| d[:user_id] } || {}
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :location, :description, :calendar_id, :summary, :start_date, :start_time,
                                  :end_date, :end_time, :all_day, :status, :participants, :recur, :period, :frequency,
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

  def prepare_event_attr
    {
        title: event_params[:title],
        description: event_params[:description],
        location: event_params[:location],
        starts_at: event_params[:all_day] ? convert_query_date(:start_date) : convert_query_time(:start_date, :start_time),
        ends_at: event_params[:all_day] ? convert_query_date(:end_date) : convert_query_time(:end_date, :end_time),
        all_day: event_params[:all_day],
        last_updated_by: @user.id
    }
  end

end
