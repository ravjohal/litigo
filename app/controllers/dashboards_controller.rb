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
      @user.firm = @firm
      @user.save!
    end

    respond_to do |format|
      if @firm.save
        create_contact
        format.html { render :show, notice: 'Firm and Contact were successfully created.' }
        #format.json { render :show, status: :created, location: @firm }
      else
        format.html { render :new }
        #format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_contact

    # contact = Contact.new
    class_string_name = params[:firm][:contact][:type]

    if class_string_name == "Staff/Paralegal"
      class_string_name = "Staff"
    end
    
    contact = class_string_name.constantize.new
    
    puts " FIRST NAME: " + @user.first_name

    contact.first_name = @user.first_name
    contact.last_name = @user.last_name
    contact.user = @user
    contact.firm = @firm
    contact.save! 
  end
end
