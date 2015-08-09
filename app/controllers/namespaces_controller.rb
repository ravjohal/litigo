class NamespacesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  before_action :set_namespace, only: [:show, :edit, :update, :destroy, :destroy_calendar]

  # GET /namespaces
  # GET /namespaces.json
  def index
    @namespaces = @user.namespaces
    # if @namespaces.present?
    #   @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, @namespaces.first.inbox_token)
    #   @inbox.accounts.each do |a|
    #     ns = @namespaces.find_by(account_id: a.account_id)
    #     status = a.sync_state.downcase == 'running' ? 'active' : a.sync_state.downcase
    #     ns.update(account_status: status) if ns.present?
    #   end
    # end
  end

  def get_calendars
    namespace = Namespace.find(params[:id])
    @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
    nylas_namespace = @inbox.namespaces.first
    calendars = nylas_namespace.calendars.all
    calendars.each do |nc|
      calendar = Calendar.find_or_initialize_by(namespace_id: namespace.id, calendar_id: nc.id, firm_id: @firm.id)
      calendar.update(description: nc.description, name: nc.name, nylas_namespace_id: nc.namespace_id)
    end
    if calendars.present?
      render :json => { success: true, message: "#{calendars.count} calendars were fetched." }
    else
      render :json => { success: 403, message: 'Calendars fetching error.' }
    end
  end

  def get_mass_calendar_events
    namespace = Namespace.find(params[:namespace_id])
    sync_period = params[:sync_period].to_i
    @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
    ns = @inbox.namespaces.first
    events_synced = 0
    active_calendar_ids = params[:active_ids]
    inactive_calendar_ids = params[:inactive_ids]
    user_calendars = @user.calendars
    nylas_calendar_ids = {}

    if active_calendar_ids.present?
      active_calendar_ids.each do |active_id|
        cal = user_calendars.find(active_id)
        if cal.present?
          nylas_calendar_ids[active_id] = cal.try(:calendar_id)
          cal.update(active: true)
        end
      end
    end
    deleted_events = 0
    if inactive_calendar_ids.present?
      inactive_calendar_ids.each do |inactive_id|
        cal = user_calendars.find(inactive_id)
        if cal.present?
          cal.update(active: false)
          cal_events = cal.events
          deleted_events += cal_events.count
          cal_events.destroy_all
        end
      end
    end

    if active_calendar_ids.present?
      events = sync_period > 0 ? ns.events.where(starts_after: (Time.now - sync_period.months).to_i) : ns.events
      events.all.each do |ne|
        if nylas_calendar_ids.has_value?(ne.calendar_id)
          event = Event.find_or_initialize_by(nylas_event_id: ne.id)
          event.assign_attributes(nylas_calendar_id: ne.calendar_id, nylas_namespace_id: ne.namespace_id, description: ne.description,
                                  location: ne.location, read_only: ne.read_only, title: ne.title, busy: ne.try(:busy), status: ne.try(:status),
                                  when_type: ne.when['object'], created_by: @user.id, owner_id: namespace.user_id, firm_id: @firm.id, calendar_id: nylas_calendar_ids.key(ne.calendar_id),
                                  namespace_id: namespace.id)
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
            participant = Participant.find_or_create_by(email: np['email'], name: np['name'], firm_id: @firm.id)
            ep = EventParticipant.find_or_initialize_by(event_id: event.id, participant_id: participant.id, firm_id: @firm.id)
            ep.update(status: np['status'])
          end
          events_synced += 1
        end
      end
      namespace.update(last_sync: Time.now, sync_period: sync_period)
    end
    message = "#{events_synced} events were synchronized."
    message += " #{deleted_events} events were deleted." if deleted_events > 0
    render :json => { success: true, message: message }
  end

  # GET /namespaces/1
  # GET /namespaces/1.json
  def show
    @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, @namespace.inbox_token)
    nylas_namespace = @inbox.namespaces.first
    calendars = nylas_namespace.calendars.all
    calendars.each do |nc|
      calendar = Calendar.find_or_initialize_by(namespace_id: @namespace.id, calendar_id: nc.id, firm_id: @firm.id)
      calendar.update(description: nc.description, name: nc.name, nylas_namespace_id: nc.namespace_id)
    end
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
    @namespace.firm = @firm
    
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

  # DELETE /namespaces/1/1
  # DELETE /namespaces/1/1.json
  def destroy_calendar
    @calendar = Calendar.find params[:calendar_id]
    if @calendar.delete!
      respond_to do |format|
        format.html { redirect_to namespace_url(@namespace), notice: 'Calendar was successfully destroyed.' }
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
