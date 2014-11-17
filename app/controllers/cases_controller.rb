class CasesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!
  before_action :set_case, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  def index
    @cases = @user.cases.includes(:medical)
    @new_path = new_case_path
  end

  def show
    @case = Case.find(params[:id])
    restrict_access("cases") if @case.user_id != current_user.id
  end

  def new
    @case = Case.new

  end

  def edit
    @case = Case.find(params[:id])
    restrict_access("cases") if @case.user_id != current_user.id
  end
  
  def create
    inj_type = params[:case][:medical_attributes][:injuries_attributes]["0"][:injury_type]

    if inj_type != ''
      puts "INJURY TYPEE -----> " + inj_type
      params[:case][:medical_attributes][:injuries_attributes]["0"][:primary] = true
    else
      params[:case][:medical_attributes].delete(:injuries_attributes)
    end

    @case = Case.new(case_params)
    @case.user = @user
    @case.firm = @firm


    # incident = @case.build_incident
    # incident.firm = @firm
    # incident.save

    resolution = @case.build_resolution
    resolution.firm = @firm
    resolution.save

    # medical = @case.build_medical
    # medical.firm = @firm
    # medical.save



    # injury = medical.tasks.create
    # injury.firm = @firm
    # injury.save

    if @case.save
      redirect_to @case, notice: 'Case was successfully created.'
    else
      render :new
    end
  end

  respond_to :html, :json
  def update
    @case.user = @user
    @case.update_attributes(case_params)
    respond_with @case, notice: 'Case was successfully updated.'
  end

  def destroy
    @case.destroy
    redirect_to cases_url, notice: 'Case was successfully deleted.'
  end

  private
    def set_case
      @case = Case.find(params[:id])
    end

    def case_params
      params.require(:case).permit(:name, :case_number, :docket_number, :description, :case_type, :subtype,
        :court, :county, :plaintiff, :defendant, :corporation, :status,
        :creation_date, :closing_date, :state, :medical_bills,
        :medical_attributes => [:total_med_bills, :subrogated_amount, :injuries_within_three_days, :length_of_treatment, :doctor_type, :treatment_type, :created_at, :updated_at, :id, 
        :injuries_attributes => [:injury_type, :region, :code, :created_at, :updated_at, :primary, :id]], 
        :incident_attributes => [:incident_date, :statute_of_limitations, :defendant_liability, :alcohol_involved, :weather_factor, :property_damage, :airbag_deployed, :speed, :police_report, :insurance_provider, :created_at, :updated_at, :id], 
        :resolution_attributes => [:id, :updated_at, :created_at, :firm_id, :settlement_demand, :jury_demand, :resolution_amount, :resolution_type], 
        :event_ids => [], :contact_ids => [], :task_ids => [], :document_ids => [])
    end
end
