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
  
    puts "GET MASS CALENDAR STARTING __________ " + params.inspect
    sync_calendar(params, @user.id)

    # The following has been moved to background job:

    # namespace = Namespace.find(params[:namespace_id])
    # sync_period = params[:sync_period].to_i

    # user_calendars = @user.calendars

    # ns = namespace.nylas_namespace

    # events_synced = 0
    # active_calendar_ids = params[:active_ids]
    # inactive_calendar_ids = params[:inactive_ids]
    # nylas_calendar_ids = {}

    # if active_calendar_ids.present?
    #   user_calendars.select(:id, :calendar_id).where(id: active_calendar_ids).each { |cal| nylas_calendar_ids[cal.id] = cal.try(:calendar_id) }
    #   user_calendars.where(id: active_calendar_ids).update_all active: true
    # end

    # deleted_events = 0
    # if inactive_calendar_ids.present?
    #   event_condition = Event.where(calendar_id: inactive_calendar_ids)
    #   deleted_events += event_condition.count
    #   event_condition.destroy_all
    #   user_calendars.where(id: inactive_calendar_ids).update_all active: false
    # end

    # if active_calendar_ids.present?
    #   events = sync_period > 0 ? ns.events.where(starts_after: (Time.now - sync_period.months).to_i) : ns.events
    #   events.each do |ne|
    #     if nylas_calendar_ids.has_value?(ne.calendar_id)
    #       event = Event.find_or_initialize_by(nylas_event_id: ne.id)
    #       event.assign_nylas_object! ne, @firm do
    #         event.assign_attributes created_by: @user.id, owner_id: namespace.user_id, firm_id: @firm.id, calendar_id: nylas_calendar_ids.key(ne.calendar_id), namespace_id: namespace.id
    #       end
    #       events_synced += 1
    #     end
    #   end
    #   namespace.update(last_sync: Time.now, sync_period: sync_period)
    # end

    # message = "#{events_synced} events were synchronized."
    # message += " #{deleted_events} events were deleted." if deleted_events > 0
    # render :json => { success: true, message: message }

    message = "Background process is running to sync your calendar(s).  Please check your calendar shortly." 
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

  def sync_calendar(params, user_id_)
    params_ = params.deep_dup
    params_[:user_id] = user_id_

    Resque.enqueue(SyncCalendar, params_)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_namespace
      @namespace = Namespace.find(params[:id])
    end
end
