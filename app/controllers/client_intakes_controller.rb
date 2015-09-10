class ClientIntakesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_client_intake
  before_action :set_user, :set_firm

  helper DatesHelper

  # GET /client_intakes
  # GET /client_intakes.json
  def index
    # @leads = @firm.leads
    # @my_leads = @leads.where(attorney_id: current_user.id)
    @lead = Lead.new
    respond_to do |format|
      format.html
      format.json { render json: LeadsDatatable.new(view_context, current_user, false) }
    end
  end

  # GET /client_intakes/1
  # GET /client_intakes/1.json
  def show
  end

  def show_lead_contact
  end

  def lead_documents
    @my_documents = @lead.documents.where(user_id: @user.id)
    @documents = @lead.documents
  end

  # GET /client_intakes/new
  def new
    @lead = Lead.new
  end

  # GET /client_intakes/1/edit
  def edit
  end

  def edit_lead_contact
  end

  # POST /client_intakes
  # POST /client_intakes.json
  def create
    @lead = Lead.new(client_intake_params)
    @lead.firm = @firm
    @lead.screener_id = current_user.id
    respond_to do |format|
      if @lead.save
        format.html { redirect_to lead_path(@lead), notice: 'Client intake was successfully created.' }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_intakes/1
  # PATCH/PUT /client_intakes/1.json
  def update
    respond_to do |format|
      if @lead.update(client_intake_params)
        format.html { redirect_to lead_path(@lead), notice: 'Client intake was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_intakes/1
  # DELETE /client_intakes/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Client intake was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_leads
    respond_to do |format|
      format.json { render json: LeadsDatatable.new(view_context, current_user, true) }
    end
  end

  def accept_case
    return redirect_to lead_path(@lead), alert: "Case already creaded from that lead" if Case.where(:lead_id => @lead.id).exists?
    @lead.update_attribute(:status,:accepted)
    case_attributes = @lead.generate_case_attrs(@user)
    @case = Case.new(case_attributes)
    @case.current_user_id = @user.id
    @case.lead = @lead

    respond_to do |format|
      if @case.save

        if @case.case_type == "Personal Injury" || @case.case_type == "Wrongful Death"
          incident = @case.build_incident
          incident.firm = @firm
          incident.incident_date = @lead.incident_date if @lead.incident_date.present?
          incident.save

          medical = @case.build_medical
          medical.firm = @firm
          medical.save

          if @lead.primary_injury.present?
            injury = medical.injuries.build
            injury.injury_type = @lead.try(:primary_injury)
            injury.region = @lead.try(:primary_region)
            injury.primary_injury = true
            injury.firm = @firm
            injury.save
          end

          insurance = @case.build_insurance
          insurance.firm = @firm
          insurance.save
        end

        resolution = @case.build_resolution
        resolution.firm = @firm
        resolution.estimated_value = @lead.estimated_value
        resolution.save

        contact = Contact.create({
                                     :type => 'Plaintiff',
                                     :first_name => @lead.first_name,
                                     :last_name => @lead.last_name,
                                     :address => @lead.address,
                                     :city => @lead.city,
                                     :state => @lead.state,
                                     :zip_code => @lead.zip_code,
                                     :email => @lead.email,
                                     :phone_number => @lead.phone,
                                     :date_of_birth => @lead.dob,
                                     :encrypted_ssn => @lead.ssn,
                                     :firm_id => @lead.firm_id,
                                     :user_id => @user.id
                                 })

        # @lead.update(case_id: @case.id)
        if @lead.documents.present?
          @lead.documents.each do |doc|
            CaseDocument.create(case_id: @case.id, document_id: doc.id)
          end
        end
        CaseContact.create(case_id: @case.id, contact_id: contact.id, firm_id: @case.firm_id, role: 'Plaintiff')

        user_account_contact =  Contact.select(:id).where(:user_account_id => @lead.attorney_id).first
        CaseContact.create(case_id: @case.id, contact_id: user_account_contact.id, firm_id: @case.firm_id, role: 'Attorney') if user_account_contact.present?
        @case.check_sol
        format.html { redirect_to case_path(@case), notice: 'Case was successfully created.' }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { redirect_to request.referer, alert: "#{@case.errors.full_messages.join('. ')}" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_intake
      @lead = Lead.find(params[:id]) if params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_intake_params
      params.require(:lead).permit(:first_name, :last_name, :attorney_id, :note, :phone, :marketing_channel, 
                                  :phone_book, :referred_by, :screener_id, :case_type, :sub_type, :estimated_value, 
                                  :lead_policy_limit, :primary_injury, :primary_region, :incident_date, :case_summary, 
                                  :status, :appointment_date, :attorney_already, :attorney_name, :dob, :email, :address, 
                                  :city, :zip_code, :state, :referring_contact_id, :ssn)
    end
end
