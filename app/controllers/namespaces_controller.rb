class NamespacesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  before_action :set_namespace, only: [:show, :edit, :update, :destroy]

  # GET /namespaces
  # GET /namespaces.json
  def index
    @namespaces = @user.namespaces
    @inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, @namespaces.first.inbox_token)
    @inbox.accounts.each do |a|
      ns = @namespaces.find_by(account_id: a.account_id)
      ns.update(account_status: a.sync_state) if ns.present?
    end
  end

  def get_calendars
    namespace = Namespace.find(params[:id])
    @inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
    nylas_namespace = @inbox.namespaces.first
    calendars = nylas_namespace.calendars.all
    calendars.each do |nc|
      calendar = Calendar.find_or_initialize_by(namespace_id: namespace.id, calendar_id: nc.id)
      calendar.update(description: nc.description, name: nc.name, nylas_namespace_id: nc.namespace_id)
    end
    if calendars.present?
      render :json => { success: true, message: "#{calendars.count} calendars were fetched." }
    else
      render :json => { success: 403, message: 'Calendars fetching error.' }
    end
  end

  def get_events
    calendar = Calendar.find(params[:id])
    @inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, calendar.namespace.inbox_token)
    namespace = @inbox.namespaces.first
    events = namespace.events.where(:calendar_id => calendar.calendar_id)
    events.all.each do |ne|
      event = Event.find_or_initialize_by(user_id: @user.id, nylas_event_id: ne.id)
      event.assign_attributes(nylas_calendar_id: ne.calendar_id, nylas_namespace_id: ne.namespace_id, description: ne.description,
                              location: ne.location, read_only: ne.read_only, title: ne.title, busy: ne.try(:busy), status: ne.try(:status),
                              when_type: ne.when['object'], user_id: @user.id, firm_id: @firm.id, calendar_id: calendar.id, namespace_id: calendar.namespace_id)
      case ne.when['object']
        when "date"
          event.starts_at = ne.when['date']
          event.ends_at = ne.when['date']
        when "datespan"
          event.starts_at = ne.when['start_date']
          event.ends_at = ne.when['end_date']
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
        EventParticipant.create(event_id: event.id, participant_id: participant.id, status: np['status'])
      end
    end
    if events.present?
      render :json => { success: true, message: "#{events.count} events were synchronized." }
    else
      render :json => { success: 403, message: 'Synchronization error.' }
    end
  end

  def get_mass_calendar_events
    namespace = Namespace.find(params[:namespace_id])
    @inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
    ns = @inbox.namespaces.first
    events = ns.events
    calendar_ids = params[:ids]
    events_synced = 0
    calendar_ids.each do |id|
      calendar = Calendar.find(id)
      nylas_events = events.where(:calendar_id => calendar.calendar_id)
      nylas_events.each do |ne|
        event = Event.find_or_initialize_by(user_id: @user.id, nylas_event_id: ne.id)
        event.assign_attributes(nylas_calendar_id: ne.calendar_id, nylas_namespace_id: ne.namespace_id, description: ne.description,
                                location: ne.location, read_only: ne.read_only, title: ne.title, busy: ne.try(:busy), status: ne.try(:status),
                                when_type: ne.when['object'], user_id: @user.id, firm_id: @firm.id, calendar_id: calendar.id, namespace_id: calendar.namespace_id)
        case ne.when['object']
          when "date"
            event.starts_at = ne.when['date']
            event.ends_at = ne.when['date']
          when "datespan"
            event.starts_at = ne.when['start_date']
            event.ends_at = ne.when['end_date']
          when "time"
            event.starts_at = Time.at(ne.when['time']).utc.to_datetime
            event.ends_at = Time.at(ne.when['time']).utc.to_datetime
          when "timespan"
            event.starts_at = Time.at(ne.when['start_time']).utc.to_datetime
            event.ends_at = Time.at(ne.when['end_time']).utc.to_datetime
        end
        event.save!
        ne.participants.each do |np|
          participant = Participant.find_or_create_by(email: np['email'], name: np['name'])
          EventParticipant.create(event_id: event.id, participant_id: participant.id, status: np['status'])
        end
        events_synced += 1
      end
      calendar.update(active: true)
    end
    if events.present?
      render :json => { success: true, message: "#{events_synced} events were synchronized." }
    else
      render :json => { success: 403, message: 'Synchronization error.' }
    end
  end

  # GET /namespaces/1
  # GET /namespaces/1.json
  def show
  end

  # GET /namespaces/new
  def new
    redirect_to login_path
  end

  # GET /namespaces/1/edit
  def edit
  end

  # POST /namespaces
  # POST /namespaces.json
  def create
    @namespace = Namespace.new(namespace_params)

    respond_to do |format|
      if @namespace.save
        format.html { redirect_to @namespace, notice: 'Namespace was successfully created.' }
        format.json { render :show, status: :created, location: @namespace }
      else
        format.html { render :new }
        format.json { render json: @namespace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /namespaces/1
  # PATCH/PUT /namespaces/1.json
  def update
    respond_to do |format|
      if @namespace.update(namespace_params)
        format.html { redirect_to @namespace, notice: 'Namespace was successfully updated.' }
        format.json { render :show, status: :ok, location: @namespace }
      else
        format.html { render :edit }
        format.json { render json: @namespace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /namespaces/1
  # DELETE /namespaces/1.json
  def destroy
    if @namespace.destroy
      respond_to do |format|
        format.html { redirect_to namespaces_url, notice: 'Namespace was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_namespace
      @namespace = Namespace.find(params[:id])
    end
end
