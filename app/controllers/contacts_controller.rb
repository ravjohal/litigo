class ContactsController < ApplicationController
  before_filter :authenticate_user!
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
    if get_case
      @contact = @case.contacts.create(contact_params)
      path_contacts =  case_contacts_path
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

    #TODO: Not sure why, but attorney_type is NOT beign emptied out when Contact Type is of something
    # else besides Attorney. Need to look into this when there is a chance since Attorney Type can be
    # persisted once and then never emptied if the Contact Type is changed (which doesn't happen often luckily)


    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :middle_name, :last_name, :address, :city, :state, :ssn, :married, :employed, :parent, :prefix,
                                      :country, :phone_number, :fax_number, :email, :gender, :age, :type, :case_id, :salary, :website,
                                      :user_id, :contact_user_id, :corporation, :note, :firm, :attorney_type, :zip_code, :date_of_birth, :minor, 
                                      :deceased, :date_of_death, :major_date, :mobile, :company_id,
                                      :firms_attributes => [:name, :address, :zip])
    end

end
