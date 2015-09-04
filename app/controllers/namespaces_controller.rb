class NamespacesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  before_action :set_namespace, only: [:show, :edit, :update, :destroy, :destroy_calendar]

  # GET /namespaces
  # GET /namespaces.json
  def index
    @namespaces = @user.enabled_namespaces
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
    nylas = namespace.nylas_inbox
    calendars = nylas.calendars.all
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
    sync_calendar(params, @user.id)

    user_calendars = @user.calendars
    active_calendar_ids = params[:active_ids]
    inactive_calendar_ids = params[:inactive_ids]

    user_calendars.where(id: active_calendar_ids).update_all(active: true)    if active_calendar_ids.present?
    user_calendars.where(id: inactive_calendar_ids).update_all(active: false) if inactive_calendar_ids.present?

    message = "Background process is running to sync your calendar(s).  Please check your calendar shortly." 
    render :json => { success: true, message: message }
  end

  # GET /namespaces/1
  # GET /namespaces/1.json
  def show
    nylas = @namespace.nylas_inbox
    calendars = nylas.calendars.all
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
    if @namespace.delayed_destroy
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
