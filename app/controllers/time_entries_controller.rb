class TimeEntriesController < ApplicationController
  before_action :set_time_entry, except: [:index, :create, :set_timer, :get_timer, :reset_timer]
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  respond_to :html, :xml, :json

  # GET /time_entries
  # GET /time_entries.json
  def index
    @time_entries = @firm.time_entries.includes(:user, :case)
  end

  # GET /time_entries/1
  # GET /time_entries/1.json
  def show
  end

  def expenses
  end

  def invoices
  end
  # GET /time_entries/1/edit
  def edit
  end

  def edit_expenses

  end

  # POST /time_entries
  # POST /time_entries.json
  def create
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.user = @user
    respond_to do |format|
      if @time_entry.save
        format.html { redirect_to @time_entry, notice: 'Time entry was successfully created.' }
        format.json { render :show, status: :created, location: @time_entry }
      else
        format.html { render :new }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_entries/1
  # PATCH/PUT /time_entries/1.json
  def update
    respond_to do |format|
      if @time_entry.update(time_entry_params)
        format.html { redirect_to @time_entry, notice: 'Time entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_entry }
      else
        format.html { render :edit }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_entries/1
  # DELETE /time_entries/1.json
  def destroy
    @time_entry.destroy
    respond_to do |format|
      format.html { redirect_to time_entries_url, notice: 'Time entry was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def set_timer
    timer_params = params["timer"]
    session["timer"] = {} if session["timer"].blank?
    session["timer"]["stop_duration"] = 0 if session["timer"]["stop_duration"].blank?
    if timer_params["init_timer_time"].present?
      session["timer"] = timer_params
      session["timer"]["flagclock"] = 'running'
    elsif timer_params["start_time"].present? && session["stop_time"].blank?
      session["timer"]["start_time"] = timer_params["start_time"]
      session["timer"]["flagclock"] = 'running'
    elsif timer_params["start_time"].present? && session["stop_time"].present?
      session["timer"]["stop_duration"] = session["timer"]["stop_duration"] + (timer_params["start_time"].to_i - session["timer"]["stop_time"].to_i)
      session["timer"]["start_time"] = timer_params["start_time"]
      session["timer"]["flagclock"] = 'running'
    elsif timer_params["stop_time"].present?
      session["timer"]["stop_time"] = timer_params["stop_time"]
      session["timer"]["flagclock"] = 'stopped'
    end
    session["timer"]["clock_value"] = timer_params["clock_value"]
    respond_to do |format|
      format.json { render json: {status: :ok} }
    end
  end

  def get_timer
    respond_to do |format|
      format.json { render json: {timer: session[:timer], status: :ok} }
    end
  end

  def reset_timer
    session.delete("timer")
    respond_to do |format|
      format.json { render json: {status: :ok} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_entry_params
      params.require(:time_entry).permit(:date, :hours, :case_id, :description, :charge_type, :hourly_rate, :activity,
                                         :contingent_fee, :fixed_fee, :aba_code)
    end
end
