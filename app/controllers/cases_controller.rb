class CasesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_case, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  def index
    @cases = @user.cases
  end

  def show
  end

  def new
    @case = Case.new
  end

  def edit
  end

  def create
    @case = Case.new(case_params)
    @case.user = @user
    @case.firm = @firm

    resolution = @case.build_resolution
    resolution.firm = @firm
    resolution.save

    if @case.save
      redirect_to @case, notice: 'Case was successfully created.'
    else
      render :new
    end
  end

  def update
    @case.user = @user
    if @case.update(case_params)
      redirect_to @case, notice: 'Case was successfully updated.'
    else
      render :edit
    end
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
      params.require(:case).permit(:name, :number, :description, :case_type, :subtype,
        :court, :plaintiff, :defendant, :corporation, :status,
        :creation_date, :closing_date, :state, :medical_bills, 
        :medical_attributes => [:total_med_bills, :subrogated_amount, :injuries_within_three_days, :length_of_treatment, :doctor_type, :treatment_type, :created_at, :updated_at, :id, 
          :injuries_attributes => [:injury_type, :region, :code, :created_at, :updated_at, :id]], 
        :incident_attributes => [:incident_date, :statute_of_limitations, :defendant_liability, :alcohol_involved, :weather_factor, :property_damage, :airbag_deployed, :speed, :police_report, :created_at, :updated_at, :id], 
        :resolution_attributes => [:id, :updated_at, :created_at, :firm_id, :settlement_demand, :jury_demand, :resolution_amount, :resolution_type], 
        :event_ids => [], :contact_ids => [], :task_ids => [], :document_ids => [])
    end
end
