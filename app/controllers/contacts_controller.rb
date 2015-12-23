class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_case, only: [:assign_contacts, :update_case_contacts]
  before_action :case_contacts_params, only: [:update_case_contacts]
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :contact_cases]
  before_action :set_user, :set_firm

  helper DatesHelper

  # GET /contacts
  # GET /contacts.json
  def index
    if session[:saved_contact]
      @saved_contact = Contact.find(session[:saved_contact])
      session[:saved_contact] = nil
    end

    if get_case
      @contacts = @case.contacts.where.not(:type => "Company")
      @new_path = new_case_contact_path(@case)
      @contacts_a = [@case, Contact.new] #for modal partial rendering
    else
      @contacts = @firm.contacts.where.not(:type => "Company")
      @new_path = new_contact_path
      @contacts_a = Contact.new #for modal partial rendering
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])
    @company = @contact.company
    @company = Company.new if !@company
    @company_path_ = @company.id ? company_path(@company) :  " "
    restrict_access("contacts") if @contact.firm_id != @firm.id
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    restrict_access("contacts") if @contact.firm_id != @firm.id    
  end

  respond_to :html, :json, :js

  def fly_create_contact
    @contact = Contact.new(contact_params)
    @contact.user = @user
    @contact.firm = @firm
    if @contact.save
      respond_to do |format|
         format.html { redirect_to :back }
         format.json { render :nothing => true, :status => :ok }
         format.js { render :nothing => true, :status => :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, :notice => @contact.errors }
        format.json { render :json => {errors: @contact.errors}, :status => :bad_request }
        format.js { render :json => {errors: @contact.errors}, :status => :bad_request }
      end
    end
  end


  # POST /contacts
  # POST /contacts.json
  def create

    # if contact_params[:type] == 'Expert Witness'
    #   expert_witness = contact_params[:type]
    #   expert_witness = 'ExpertWitness'
    #   # contact_attrs[:type] = 'ExpertWitness'
    #   # contact_params = contact_attrs
    #   params[:contact][:type] = expert_witness.gsub(/\s+/, "")
    # end

    if get_case
      @contact = contact_params[:type] == 'Plaintiff' ? @case.plaintiffs.create(contact_params) : @case.contacts.create(contact_params)
      path_contacts =  show_case_contacts_path(@case)
      @contact.case_contacts.each do |case_contact|
        case_contact.role = @contact.type
        case_contact.firm = @firm
        case_contact.save!
      end
    else
      @contact = Contact.new(contact_params)
      path_contacts = contacts_path
    end

    # TODO: render partials per each type

    @contact.user = @user
    @contact.firm = @firm

    if @contact.type != 'Attorney'
      @contact.attorney_type = ''
    end

    #@case.contacts << @contact

    respond_to do |format|
      if @contact.save
        track_activity @contact
        format.html {
          session[:saved_contact] = @contact.id if @contact.similar_contact?
          redirect_to path_contacts, notice: 'Contact was successfully created.'
        }
        format.json { render :show, status: :created, contact: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    can_update = true

    if @contact.user_account && !@contact.user_account.disabled
      if contact_params[:type] != "Staff" && contact_params[:type] != "Attorney"
        can_update = false
      end
    end

    #puts "CONTACT UPDATE ------------------ BEFORE SAVE: " + contact_params[:type]
    
    if contact_params[:type] == 'Expert Witness'
      expert_witness = contact_params[:type]
      expert_witness = 'ExpertWitness'
      # contact_attrs[:type] = 'ExpertWitness'
      # contact_params = contact_attrs
      params[:contact][:type] = expert_witness.gsub(/\s+/, "")
    end

    #TODO: Not sure why, but attorney_type is NOT beign emptied out when Contact Type is of something
    # else besides Attorney. Need to look into this when there is a chance since Attorney Type can be
    # persisted once and then never emptied if the Contact Type is changed (which doesn't happen often luckily)

    @contact.user = @user

    respond_to do |format|
      if can_update
        if @contact.update(contact_params)
          track_activity @contact
          if @contact.type == "Company"
            company_contacts = params[:contact][:contacts_attributes] if params[:contact][:contacts_attributes]
            if company_contacts
              company_contacts.each do |key, contact_param|
                contact = Contact.find(contact_param[:id])
                destroy = contact_param[:_destroy]
                if destroy == "1"
                  contact.company_id = ""
                  contact.save!
                end
              end
            end
            format.html { redirect_to company_path(@contact), notice: 'Company was successfully updated.' }
          else 
            format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
            format.json { render :show, status: :ok, location: @contact }
          end
        else
          format.html { render :edit }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @contact, alert: 'Contact cannot be updated because it is linked to an Active User.' }
      end
    end
  end

  def info
    @contact = Contact.find(params[:id])
    restrict_access("contacts") if @contact.firm_id != @firm.id
  end

  def personal
   @contact = Contact.find(params[:id])
    restrict_access("contacts") if @contact.firm_id != @firm.id
  end

  def coinfo
    @contact = Contact.find(params[:id])
    @company = @contact.company
    @company = Company.new if !@company
    @company_path_ = @company.id ? company_path(@company) :  " "
    restrict_access("contacts") if @contact.firm_id != @firm.id
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    if @contact.user_account && !@contact.user_account.disabled
      notice = 'Contact cannot be destroyed because this contact is linked to an Active User.'
      redirect_url = @contact
    else
      @contact.destroy
      track_activity @destroy
      notice = 'Contact was successfully destroyed.'
      redirect_url = contacts_url
    end
    respond_to do |format|
        format.html { redirect_to redirect_url, notice:  notice}
        format.json { head :no_content }
      end
  end

  def assign_contacts
    # if @case
    #   @contacts = {}
    #   Contact::TYPES.each do |contact_type|
    #     @contacts[contact_type.downcase] = @case.select_contact_role(contact_type)
    #   end
    # else
    #   redirect_to root_path
    # end
  end

  def update_case_contacts
    logger.info "BEFORE case_contacts_params: #{case_contacts_params}\n\n\n"
    params_for_case_contacts = case_contacts_params.clone

    #change the structure of existing hash to add note per each contact_type
    Contact::TYPES.each do |contact_type|
      contact_type = contact_type.downcase.parameterize.underscore
      new_hash = {}
      new_hash[contact_type] = case_contacts_params[contact_type]
      params_for_case_contacts[contact_type] = new_hash
      params_for_case_contacts[contact_type][:note] = params[:note][contact_type]
    end
    #logger.info "AFTER case_contacts_params: #{params_for_case_contacts}\n\n\n"
    respond_to do |format|
      if @case.assign_case_contacts(params_for_case_contacts)
        format.html { redirect_to case_contacts_path(@case), notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      end
    end
  end

  def companies
    @companies = @firm.contacts.where(:type => "Company")
    @companies_a = Company.new #for modal partial rendering
    @list = @companies and render partial: 'contacts/list' if request.xhr?
  end

  def show_company
#    puts "parameters: ------------------------>>>>>>>>>>>>> " + Contact.find(params[:id]).inspect
    @company = Contact.find(params[:id])
    @contacts = @company.contacts
    if @company.website
      if @company.website.include? "http"
        website_ = String.new(@company.website) # copy so that we will not slice original
        website_.slice! "http://"
        @website = website_
      else
        @website = @company.website
      end
    end
    @company_city_state = @company.city
  end

  def edit_company
    @company = Contact.find(params[:id])
  end

  def contact_cases
    @cases = @contact.cases.uniq
    @contacts_a = Contact.new
    @company = @contact if @contact.type == 'Company'
  end

  def remove_contact
    contact = Contact.find_by_id(params[:id])
    contact.company = ""
    contact.save

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:company_name, :suffix, :first_name, :middle_name, :last_name, :address, :address_2, :city, :state, :ssn, :married, :employed, :parent, :prefix,
                                      :country, :phone_number, :extension, :fax_number, :email, :gender, :age, :type, :case_id, :salary, :website,
                                      :user_id, :user_account_id, :corporation, :note, :firm, :attorney_type, :zip_code, :date_of_birth, :minor, :fax_number_1, :fax_number_2,
                                      :deceased, :date_of_death, :major_date, :mobile, :company_id, :job_description, :time_bound, :phone_number_1, :phone_number_2,
                                      :firms_attributes => [:name, :address, :zip, :address_2],
                                      :contacts_attributes => [:id, :_destroy, :company_id],
                                      :phones_attributes => [:id, :label, :number, :extension, :contact_id, :firm_id, :_destroy])
      end

    def case_contacts_params
      params.require(:case).permit(:case_id, :firm_id, :note => [], :attorney => [], :adjuster => [], :plaintiff => [], :defendant => [],
                                   :staff => [], :judge => [], :witness => [], :expert => [], :physician => [], :general => [], :company => [])
    end

end
