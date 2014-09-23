class IncidentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_case
  before_action :set_user

  def show
    @incident = @case.incident
  end

  def new
    @incident = @case.build_incident
  end

  # GET case/1/incidents/1/edit
  def edit
  	# @case = get_case
  	@incident = @case.incident
  end

  def create
  	@incident = @case.build_incident(incident_params)

    respond_to do |format|
      if @incident.save
        format.html { redirect_to [@case, @incident], notice: 'incident was successfully created.' }
        format.json { render :show, status: :created, location: [@case, @incident] }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
  	@incident = @case.incident

    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to [@case, @incident], notice: 'incident was successfully updated.' }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = @case.incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:incident_date, :insurance_provider, :statute_of_limitations, :defendant_liability, :alcohol_involved, :weather_factor, :property_damage, :airbag_deployed, :speed, :police_report, :case_id)
    end
end