class CasesController < ApplicationController
  respond_to :html, :json, :docx
  before_filter :authenticate_user!
  before_action :set_case, only: [:show, :edit, :update, :destroy, :doc]
  before_action :set_user, :set_firm

  def index
    #@cases = @firm.cases.includes(:medical)
    @new_path = new_case_path
    respond_to do |format|
      format.html
      format.json { render json: CasesDatatable.new(view_context, current_user, false) }
    end
  end

  def show
    @case = Case.find(params[:id])
    restrict_access("cases") if @case.firm_id != @firm.id
  end

  def new
    @case = Case.new

  end

  def edit
    @case = Case.find(params[:id])
    restrict_access("cases") if @case.firm_id != @firm.id
  end
  
  def create
    # inj_type = params[:case][:medical_attributes][:injuries_attributes]["0"][:injury_type]

    # if inj_type != ''
    #   puts "INJURY TYPEE -----> " + inj_type
    #   params[:case][:medical_attributes][:injuries_attributes]["0"][:primary_injury] = true
    # else
    #   params[:case][:medical_attributes].delete(:injuries_attributes)
    # end

    @case = Case.new(case_params)
    @case.sol_priority = 0 if case_params[:statute_of_limitations].present?
    @case.user = @user
    @case.firm = @firm

    if @case.case_type == "Personal Injury" || @case.case_type == "Wrongful Death"
      incident = @case.build_incident
      incident.firm = @firm
      incident.save

      medical = @case.build_medical
      medical.firm = @firm
      medical.save

      insurance = @case.build_insurance
      insurance.firm = @firm
      insurance.save
    end

    resolution = @case.build_resolution
    resolution.firm = @firm
    resolution.save

    if case_params[:attorney] || case_params[:staff]
      @case.assign_case_contacts(case_contacts_params)
      #@case.assign_case_contacts(case_contacts_params)
    end
    #@case.assign_case_contacts(case_contacts_params)

    # injury = medical.tasks.create
    # injury.firm = @firm
    # injury.save
    @case.current_user_id = @user.id
    if @case.save
      redirect_to @case, notice: 'Case was successfully created.'
    else
      redirect_to :back, alert: "Please review the problems below: #{@case.errors.full_messages.join('. ')}"
    end
  end

  respond_to :html, :json
  def update
    @case.user = @user
    @case.assign_attributes(case_params)
    if @case.statute_of_limitations_changed? && @case.statute_of_limitations.present?
      @case.sol_priority = 0
    elsif @case.statute_of_limitations_changed? && @case.statute_of_limitations.blank?
      @case.sol_priority = nil
    end
    if @case.save
      @case.check_sol
      if params[:commit] == "Assign Contacts"
        redirect_to case_contacts_path(@case), notice: 'Contacts were successfully assigned.'
      else
        respond_with @case, notice: 'Case was successfully updated.'
      end

    end
  end

  def destroy
    @case.destroy
    redirect_to cases_url, notice: 'Case was successfully deleted.'
  end

  def user_cases
    respond_to do |format|
      format.json { render json: CasesDatatable.new(view_context, current_user, true) }
    end
  end

  def summary
    @case = Case.find(params[:id])
    @last_3_notes = @case.notes.last(3).reverse
#    puts "LAST THREE NOTES " + @last_3_notes.to_s
    restrict_access("cases") if @case.firm_id != @firm.id
  end

  def doc
    respond_with(@case, filename: "my_file.docx")
  end

  private
    def set_case
      @case = Case.find(params[:id])
    end

    def case_params
      params.require(:case).permit(:name, :trial_date, :case_number, :docket_number, :description, :case_type, :subtype,
        :court, :county, :plaintiff, :defendant, :corporation, :status, :hearing_date, :filed_suit_date, :fee_agreement,
        :creation_date, :closing_date, :state, :medical_bills, :topic, :transfer_date, :statute_of_limitations,
        :medical_attributes => [:total_med_bills, :subrogated_amount, :injuries_within_three_days, :length_of_treatment, :doctor_type, :treatment_type, :created_at, :updated_at, :id, 
        :injuries_attributes => [:injury_type, :region, :code, :created_at, :updated_at, :primary_injury, :id]],
        :insurance_attributes => [:parent_id, :insurance_type, :insurance_provider, :policy_limit, :claim_number, :policy_holder, :created_at, :updated_at, :id, :case_id, :_destroy,
        :children_attributes => [:parent_id, :insurance_type, :insurance_provider, :policy_limit, :claim_number, :policy_holder, :created_at, :updated_at, :id, :case_id, :_destroy]], 
        :resolution_attributes => [:id, :updated_at, :created_at, :firm_id, :settlement_demand, :jury_demand, :resolution_amount, :resolution_type], 
        :event_ids => [], :contact_ids => [], :task_ids => [], :document_ids => [], :attorney => [], :staff => [])
    end

    def case_contacts_params
      params.require(:case).permit(:case_id, :attorney => [], :staff => [])
    end
end
