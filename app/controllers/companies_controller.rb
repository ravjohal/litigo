class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :set_user, :set_firm

  # GET /companies
  # GET /companies.json
  def index
    @companies = @firm.companies
    @companies_a = Company.new #for modal partial rendering
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @contacts = @company.contacts

    if @company.website.include? "http"
      website_ = String.new(@company.website) # copy so that we will not slice original
      website_.slice! "http://"
      @website = website_
    else
      @website = @company.website
    end

    @company_city_state = @company.company_city_and_state
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    @company_city_state = @company.company_city_and_state
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    @company.firm = @firm
    @company.user = @user

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        #TODO: not the most efficient way to remove association, need to figure out a better way to do this!!
        if company_params[:contacts_attributes]
          company_params[:contacts_attributes].each do |contact| 
          if contact[1][:_destroy].to_i == 1
            contact = Contact.find_by_id(contact[1][:id])
            contact.company_id = nil
            contact.save!
          end
        end
      end
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_contact
    contact = Contact.find_by_id(params[:id])
    contact.company = ""
    contact.save

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :address, :phone, :fax, :state, :city, :zipcode, :website, :firm_id, :user_id,
                                      :contacts_attributes => [:id, :_destroy, :company_id])
    end
end
