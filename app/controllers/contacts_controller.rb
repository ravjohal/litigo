class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_case, only: [:assign_contacts, :update_case_contacts]
  before_action :case_contacts_params, only: [:update_case_contacts]
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  # GET /contacts
  # GET /contacts.json
  def index
    if get_case
      @contacts = @case.contacts
      @new_path = new_case_contact_path(@case)
      @contacts_a = [@case, Contact.new] #for modal partial rendering
    else
      @contacts = @firm.contacts
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
      path_contacts =  case_contacts_path
      @contact.case_contacts.each do |case_contact|
        case_contact.role = @contact.type
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
        format.html { redirect_to path_contacts, notice: 'Contact was successfully created.' }
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
    @contact.user = @user
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


    respond_to do |format|
      if @contact.update(contact_params)
       # puts "CONTACT UPDATE ------------------ AFTER SAVE: " + @contact.type
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
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
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_contacts
    if @case
    @contacts = {}
    Contact::TYPES.each do |contact_type|
      @contacts[contact_type.downcase] = @case.select_contact_role(contact_type)
    end
    else
      redirect_to root_path
    end
  end

  def update_case_contacts
    logger.info "case_contacts_params: #{case_contacts_params}\n\n\n"
    respond_to do |format|
      if @case.assign_case_contacts(case_contacts_params)
        format.html { redirect_to case_contacts_path(@case), notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      end
    end
  end

  def companies
    @companies = @firm.contacts.where(:type => "Company")
    @companies_a = Company.new #for modal partial rendering
  end

  def show_company
    puts "parameters: ------------------------>>>>>>>>>>>>> " + Contact.find(params[:id]).inspect
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :middle_name, :last_name, :address, :city, :state, :ssn, :married, :employed, :parent, :prefix,
                                      :country, :phone_number, :fax_number, :email, :gender, :age, :type, :case_id, :salary, :website,
                                      :user_id, :user_account_id, :corporation, :note, :firm, :attorney_type, :zip_code, :date_of_birth, :minor, :fax_number_1, :fax_number_2,
                                      :deceased, :date_of_death, :major_date, :mobile, :company_id, :job_description, :time_bound, :phone_number_1, :phone_number_2, 
                                      :firms_attributes => [:name, :address, :zip])
      end

    def case_contacts_params
      params.require(:case).permit(:case_id, :attorney => [], :adjuster => [], :plaintiff => [], :defendant => [],
                                   :staff => [], :judge => [], :witness => [], :expert => [], :physician => [], :general => [], :company => [])
    end

end
