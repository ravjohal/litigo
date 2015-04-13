class ClientIntakesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_client_intake
  before_action :set_user, :set_firm

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
        format.html { redirect_to @lead, notice: 'Client intake was successfully created.' }
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
        format.html { redirect_to @lead, notice: 'Client intake was successfully updated.' }
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
    return redirect_to lead_path(@lead), alert: "Case already creaded from that lead" if @lead.case.present?
    case_attributes = @lead.generate_case_attrs(@user)
    @case = Case.new(case_attributes)
    @case.current_user_id = @user.id
    respond_to do |format|
      if @case.save
        @lead.update(case_id: @case.id)
        if @lead.documents.present?
          @lead.documents.each do |doc|
            CaseDocument.create(case_id: @case.id, document_id: doc.id)
          end
        end
        format.html { redirect_to case_path(@case), notice: 'Case was successfully created.' }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { redirect_to request.referer, alert: "#{@case.errors.full_messages.join('. ')}" }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  def acceptance_letter
    respond_to do |format|
      format.docx do
        # Initialize DocxReplace with your template
        doc = DocxReplace::Doc.new("#{Rails.root}/lib/docx_templates/acceptance_letter_template.docx", "#{Rails.root}/tmp")

        # Replace some variables. $var$ convention is used here, but not required.
        doc.replace("LETTER_DATE", Date.today.strftime("%B %e, %Y"))
        doc.replace("LEAD_FIRST_NAME", @lead.first_name)
        doc.replace("LEAD_LAST_NAME", @lead.last_name, true)
        doc.replace("LEAD_ADDRESS", @lead.address)
        doc.replace("LEAD_CITY", @lead.city)
        doc.replace("LEAD_STATE", @lead.state)
        doc.replace("LEAD_ZIP_CODE", @lead.zip_code)
        doc.replace("LEAD_PREFIX", 'Mr.')
        doc.replace("LEAD_DEFENDANT_NAME", 'Defendant Name')
        doc.replace("LEAD_INSURANCE_NAME", @lead.lead_insurance)
        doc.replace("USER_NAME", @user.name)
        doc.replace("USER_STAFF_INITIALS", 'AIG')


        # Write the document back to a temporary file
        tmp_file = Tempfile.new('word_tempate', "#{Rails.root}/tmp")
        doc.commit(tmp_file.path)

        # Respond to the request by sending the temp file
        send_file tmp_file.path, filename: "acceptance_letter_#{@lead.id}.docx", disposition: 'attachment'
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
      params.require(:lead).permit(:first_name, :last_name, :attorney_id, :note, :phone, :marketing_channel, :referred_by, :screener_id, :case_type, :sub_type, :estimated_value, :lead_policy_limit, :primary_injury, :primary_region, :incident_date, :case_summary, :status, :appointment_date, :attorney_already, :attorney_name, :dob, :email, :address, :city, :zip_code, :state)
    end
end
