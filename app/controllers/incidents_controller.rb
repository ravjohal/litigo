class IncidentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /incidents/1
  # GET /incidents/1.json
  def show
    add_breadcrumb (Incident.find params[:id]).case.name + ', #' + (Incident.find params[:id]).case.number.to_s,
        case_path((Incident.find params[:id]).case)
  end

  # GET /incidents/new
  def new
    if Case.find($current_case_id).incident.nil?
      @incident = Incident.new
    else
      redirect_to incident_path(Case.find($current_case_id).incident)
    end
  end

  # GET /incidents/1/edit
  def edit

    add_breadcrumb (Incident.find params[:id]).case.name + ', #' + (Incident.find params[:id]).case.number.to_s,
                   case_path((Incident.find params[:id]).case)
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)

    @incident.case = Case.find $current_case_id

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    @incident.police_report = nil unless params.has_key?('police_report')
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
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
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:date_of_incident, :statute_of_limitations, :liability,
                                       :alcohol, :weather_factor, :damage, :airbag, :speed, :police_report)
    end
end
