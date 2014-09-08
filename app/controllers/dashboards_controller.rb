class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user
  
  def new
    if current_user.firm
      puts "FIRM NAME " + current_user.firm.name
      if !@current_user.firm
        @firm = Firm.new
      else
        render :show
      end
    else
      @firm = Firm.new
    end
  end

  def show
  end

  def create
    # create_user
    # create_firm
    # create_user
    firm_name = params[:firm][:name]
    firm_from_db = Firm.find_by(:name => firm_name)
    if !firm_from_db
      @firm = Firm.new
      tenant = firm_name.gsub(/[^0-9a-z ]/i, '').tr(" ", "_") #replace whitespace and remove special characters
      @firm.name = firm_name
      @firm.phone = params[:phone]
      #@firm.zip = params[:zip]
      @firm.tenant = tenant

      puts "FIRM NAME SIGN UP: " + tenant

      @user.firm = @firm
      @user.save!
    else
      @firm = firm_from_db
    end

    respond_to do |format|
      if @firm.save
        puts "what is the current tenant: " + Apartment::Tenant.current_tenant.to_s
        if !firm_from_db
          Apartment::Tenant.create(tenant)
        # else
        #   puts " there exists a firm already " + @firm.tenant
        #   Apartment::Tenant.switch(@firm.tenant)
        #   puts "what is the current tenant: " + Apartment::Tenant.current_tenant.to_s
        end
              
        create_contact(@firm.tenant)
        format.html { render :show, notice: 'Firm and Contact were successfully created.' }
        #format.json { render :show, status: :created, location: @firm }
      else
        format.html { render :new }
        #format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_contact(tenant)
    Apartment::Tenant.switch(tenant)

    contact = Contact.new
    contactable_type = params[:firm][:contact][:contactable_type]

    if (contactable_type != "General") && (contactable_type != "Staff/Paralegal")
      class_string_name = contactable_type
      contactable = class_string_name.constantize.new
      contactable.save!
      contact.contactable = contactable
    elsif contactable_type == "Staff/Paralegal"
      class_string_name = "Staff"
      contactable = class_string_name.constantize.new
      contactable.save!
      contact.contactable = contactable
    else
      contact.contactable_type = contactable_type
    end
    contact.first_name = @user.first_name
    contact.last_name = @user.last_name
    contact.user = @user
    contact.save! 
  end
end
