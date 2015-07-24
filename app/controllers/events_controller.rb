class EventsController < ApplicationController
  include NylasHelper
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  around_filter :user_time_zone, if: :current_user

  # GET /events
  # GET /events.json
  def index
    @users = @firm.users
    @event_sources = {}
    @users.each_with_index do |user, index|
      hash = {user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(index)}
      events = []
      user.calendars.each do |calendar| 
        #puts "Calendar ------------------------------------------ " + calendar.inspect
        calendar.events.each do |event|
          event = {id: event.id, title: event.title, start: event.starts_at, end: event.ends_at, allDay: event.all_day }
          events << event
          #puts "EVENT ++++++++++++++++++++++++++++++++++++++++++++ " + event.inspect
        end
      end
      hash[:events] = events
      @event_sources[user.id] = hash
    end

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
    restrict_access("events") if @event.user_id != current_user.id     
  end

  # GET /events/new
  def new
    @event = Event.new

  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    restrict_access("events") if @event.user.firm != current_user.firm
    @model = @event
    @emails_autocomplete = emails_autocomplete
    if !@event.read_only && (current_user == @event.calendar.user || current_user.edit_event_allowed?)
      render partial: 'events/edit'
    else
      render partial: 'events/show'
    end
  end

  # POST /events
  # POST /events.json
  def create
    calendar = Calendar.find(event_params[:calendar_id]) if event_params[:calendar_id].present?
    #user_id_for_hash = calendar ? @user.id : @user.id
    #puts "USER RIGHT NOW: --------->> " + @user.inspect
    attrs = {
          title: event_params[:title],
          description: event_params[:description],
          location: event_params[:location],
          starts_at: event_params[:all_day] ? Date.strptime(event_params[:start_date], '%m/%d/%Y').strftime('%Y-%m-%d') : DateTime.strptime("#{event_params[:start_date]} #{event_params[:start_time]}", '%m/%d/%Y %H:%M %p').strftime('%Y-%m-%d %H:%M %p'),
          ends_at: event_params[:all_day] ? Date.strptime(event_params[:end_date], '%m/%d/%Y').strftime('%Y-%m-%d') : DateTime.strptime("#{event_params[:end_date]} #{event_params[:end_time]}", '%m/%d/%Y %H:%M %p').strftime('%Y-%m-%d %H:%M %p'),
          all_day: event_params[:all_day],
          user_id: @user.id,
          firm_id: @firm.id
    }
    if event_params[:recur]
      @event = EventSeries.new(attrs.merge({period: event_params[:period],
                                            frequency: event_params[:frequency],
                                            recur_start_date: Date.strptime(event_params[:recur_start_date], "%m/%d/%Y"),
                                            recur_end_date: Date.strptime(event_params[:recur_end_date], "%m/%d/%Y")}))
    else
      @event = Event.new(attrs)
    end
    if @event.save
      #puts "EVENT ******************************************************** " + @event.inspect
      @event.assign_participants(event_params[:participants]) if event_params[:participants].present?
      if calendar.present?
        namespace = calendar.namespace
        @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
        nylas_namespace = @inbox.namespaces.first
        if @event.class.name == 'Event'
          n_event = nylas_namespace.events.build(:calendar_id => calendar.calendar_id, :title => @event.title, :description => @event.description,
                                                 :location => @event.location, :when => {:start_time => @event.starts_at.to_i,
                                                                                         :end_time => @event.ends_at.to_i},
                                                 :participants => @event.participants.map {|p| { :email => p.email, :name => p.name}})
          n_event.save!
          #puts "n_event >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + n_event.inspect
          @event.update(calendar_id: calendar.id, nylas_event_id: n_event.id, nylas_calendar_id: n_event.calendar_id,
                        nylas_namespace_id: n_event.namespace_id, namespace_id: calendar.namespace_id,
                        when_type: n_event.when['object'])
          #puts "EVENT AFTER UPDATE $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ " + @event.inspect 
        #TODO figure out how to send recuring events to nylas
        elsif @event.class.name == 'EventSeries'
          @event.events.each do |e|
            n_event = nylas_namespace.events.build(:calendar_id => calendar.calendar_id, :title => e.title, :description => e.description,
                                                   :location => e.location, :when => {:start_time => e.starts_at.to_i,
                                                                                           :end_time => e.ends_at.to_i},
                                                   :participants => e.participants.map {|p| { :email => p.email, :name => p.name}})
            n_event.save!
            e.update(calendar_id: calendar.id, nylas_event_id: n_event.id, nylas_calendar_id: n_event.calendar_id,
                          nylas_namespace_id: n_event.namespace_id, namespace_id: calendar.namespace_id,
                          when_type: n_event.when['object'])
          end
        end
      end
    end
    message = @event.errors.present? ? {error: @event.errors.full_messages.to_sentence} : {notice: 'Event was successfully created.'}
    respond_to do |format|
      format.html {redirect_to request.referrer , :flash => message}
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    calendar = Calendar.find(event_params[:calendar_id]) if event_params[:calendar_id].present?
    attrs = {
        title: event_params[:title],
        description: event_params[:description],
        location: event_params[:location],
        starts_at: event_params[:all_day] ? Date.strptime(event_params[:start_date], '%m/%d/%Y').strftime('%Y-%m-%d') : DateTime.strptime("#{event_params[:start_date]} #{event_params[:start_time]}", '%m/%d/%Y %H:%M %p').strftime('%Y-%m-%d %H:%M %p'),
        ends_at: event_params[:all_day] ? Date.strptime(event_params[:end_date], '%m/%d/%Y').strftime('%Y-%m-%d') : DateTime.strptime("#{event_params[:end_date]} #{event_params[:end_time]}", '%m/%d/%Y %H:%M %p').strftime('%Y-%m-%d %H:%M %p'),
        all_day: event_params[:all_day]
    }
    if @event.event_series.present? && event_params[:update_all_events] == 'true'
      @event.event_series.update_events_until_end_time(event_params)
    else
      if @event.update(attrs)
        @event.update_participants(event_params[:participants]) if event_params[:participants].present?
        if calendar.present?
          namespace = calendar.namespace
          @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
          nylas_namespace = @inbox.namespaces.first
          n_event = nylas_namespace.events.find(@event.nylas_event_id)
          n_event.title = @event.title
          n_event.description = @event.description
          n_event.location = @event.location
          n_event.when = {:start_time => @event.starts_at.to_i, :end_time => @event.ends_at.to_i}
          n_event.participants = @event.participants.map {|p| { :email => p.email, :name => p.name}}
          n_event.save!
          @event.update(when_type: n_event.when['object']) if n_event.when['object'] != @event.when_type
        end
      end
    end

    message = @event.errors.present? ? {error: @event.errors.full_messages.to_sentence} : {notice: 'Event was successfully updated.'}
    respond_to do |format|
      format.html {redirect_to request.referrer , :flash => message}
    end
  end

  def event_drag
    @event = current_user.firm.events.find(params[:id].to_i)
    calendar = @event.calendar
    if @event.update(event_drag_params)
      if calendar.present?
        namespace = calendar.namespace
        @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
        nylas_namespace = @inbox.namespaces.first
        n_event = nylas_namespace.events.find(@event.nylas_event_id)
        n_event.when = {:start_time => @event.starts_at.to_i, :end_time => @event.ends_at.to_i}
        n_event.save!
        @event.update(when_type: n_event.when['object']) if n_event.when['object'] != @event.when_type
      end
      message = @event.errors.present? ? @event.errors.full_messages.to_sentence : 'Event was successfully updated.'
      render :json => { success: true, message: message }
    else
      render :json => "Event isn't found", status: 404
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if params[:delete_all] == 'true' && @event.event_series.present?
      @event.event_series.events.each do |e|
        calendar = e.calendar
        nylas_event_id = e.nylas_event_id
        if e.destroy
          if nylas_event_id.present? && calendar.present?
            namespace = calendar.namespace
            @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
            nylas_namespace = @inbox.namespaces.first
            n_event = nylas_namespace.events.find(nylas_event_id).destroy
          end
        end
      end
    else
      calendar = @event.calendar
      nylas_event_id = @event.nylas_event_id
      if @event.destroy
        if nylas_event_id.present? && calendar.present?
          namespace = calendar.namespace
          @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
          nylas_namespace = @inbox.namespaces.first
          n_event = nylas_namespace.events.find(nylas_event_id).destroy
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def emails_autocomplete
    users_emails = []
    @user.firm.users.map {|user| users_emails << user.email unless user.email == @user.email}
    @user.events.map do |event|
      event.participants.map {|participant| users_emails << participant.email unless participant.email == @user.email}
    end
    return users_emails.uniq
  end

  def refresh_events
    events_synced = 0
    refreshed_events = []
    @event_sources = {}
    @users = @firm.users
    namespaces = @firm.namespaces
    namespaces.each do |namespace|
      active_calendars = namespace.calendars.where(active: true)
      if active_calendars.present?
        @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
        ns = @inbox.namespaces.first
        cursor = namespace.cursor.present? ? namespace.cursor : ns.get_cursor(namespace.last_sync.to_i) #the last update of the namespace (to figure out the deltas)
        last_cursor = nil
        #puts " CURSOR: " + namespace.inspect + " --- " + cursor.inspect
        ns.deltas(cursor, exclude=[Nylas::Tag, Nylas::Calendar, Nylas::Contact, Nylas::Message, Nylas::File, Nylas::Thread]) do |event, ne| # exclude all those in array, only need events for now
          # event = action done by Nylas (modify, create, etc)
          # ne = hash of event, details of the event
          #puts " NE :::::::::::::::::::::::::::::::::::::::::::::::::::::: " + event.inspect + "  ----> " + ne.inspect
          if ne.is_a?(Nylas::Event)
              if event == "create" or event == "modify"
                calendar = active_calendars.find_by(calendar_id: ne.calendar_id)
                #puts " ACTIVE CALENDAR: 777777777777777777777777777777777777 " + calendar.inspect 
                if calendar.present?
                  event = Event.find_or_initialize_by(nylas_event_id: ne.id)
                  #puts " EVEN FIND OR INITIALIZE BY ))))))))))))))))))))))))))))))))))))))))))  " + event.inspect
                  if ne.status == 'cancelled'
                    event.destroy
                  else
                    event.assign_attributes(nylas_calendar_id: ne.calendar_id, nylas_namespace_id: ne.namespace_id, description: ne.description,
                                            location: ne.location, read_only: ne.read_only, title: ne.title, busy: ne.try(:busy), status: ne.try(:status),
                                            when_type: ne.when['object'], user_id: @user.id, firm_id: @firm.id, calendar_id: calendar.id,
                                            namespace_id: namespace.id)
                    case ne.when['object']
                      when "date"
                        event.starts_at = ne.when['date']
                        event.ends_at = ne.when['date']
                        event.all_day = true
                      when "datespan"
                        event.starts_at = ne.when['start_date']
                        event.ends_at = ne.when['end_date']
                        event.all_day = true
                      when "time"
                        event.starts_at = Time.at(ne.when['time']).utc.to_datetime
                        event.ends_at = Time.at(ne.when['time']).utc.to_datetime
                      when "timespan"
                        event.starts_at = Time.at(ne.when['start_time']).utc.to_datetime
                        event.ends_at = Time.at(ne.when['end_time']).utc.to_datetime
                    end
                    event.save
                    ne.participants.each do |np|
                      participant = Participant.find_or_create_by(email: np['email'], name: np['name'])
                      ep = EventParticipant.find_or_initialize_by(event_id: event.id, participant_id: participant.id)
                      ep.update(status: np['status'])
                    end
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

    @users.each_with_index do |user, index|
      hash = {user_name: user.name, color: user.events_color.present? ? user.events_color : user.color(index)}
      events = []
      user.calendars.each do |calendar|
          calendar.events.each do |event|
          event = {id: event.id, title: event.title, start: event.starts_at, end: event.ends_at, allDay: event.all_day}
          events << event
        end
      end
      hash[:events] = events
      #puts " HASH &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& " + hash.inspect
      @event_sources[user.id] = hash
    end

    #puts " EVENT SOURCES ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ " + @event_sources.inspect 
    message = "#{events_synced} events were synced."
    respond_to do |format|
      format.html {redirect_to request.referrer , notice: message}
      format.json {render json: {events: @event_sources, events_synced: events_synced, message: message} }
    end
  end

  def get_user_events
    user = User.find(params[:user_id])
    @events = @firm.events.where(owner_id: user.id)
    events_list = @firm.events.where(owner_id: user.id).select([:id, :subject, :start, :end, :all_day]).map {|e| {id: e.id,
                                                                                                 title: '',
                                                                                                 start: e.all_day ? "#{e.start.to_date}" : "#{e.start.to_datetime}",
                                                                                                 end: e.all_day ? "#{e.end.to_date-1.day}" : "#{e.end.to_datetime}",
                                                                                                 allDay: e.all_day} }
    respond_to do |format|
      format.json { render json: {events: events_list} }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :location, :description, :calendar_id, :summary, :start_date, :start_time,
                                  :end_date, :end_time, :all_day, :status, :participants, :recur, :period, :frequency,
                                  :recur_start_date, :recur_end_date, :event_series_id, :update_all_events)
  end

  def event_drag_params
    params.require(:event).permit(:starts_at, :ends_at)
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
end
