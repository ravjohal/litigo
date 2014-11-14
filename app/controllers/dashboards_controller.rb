class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user
  
  def new
    if current_user.firm
      render :show
    else
      @firm = Firm.new
    end
  end

  def show
  end

  def create

    firm_name = params[:firm][:name]
    firm_from_db = Firm.find_by(:name => firm_name)
    #if !firm_from_db
      @firm = Firm.new
      tenant = firm_name.gsub(/[^0-9a-z ]/i, '').tr(" ", "_") #replace whitespace and remove special characters
      @firm.name = firm_name
      @firm.phone = params[:phone]
      #@firm.zip = params[:zip]
      @firm.tenant = tenant

      puts "FIRM NAME SIGN UP: " + tenant

      @user.firm = @firm
      @user.role = :admin
   # else
   #   @firm = firm_from_db
   #   @user.firm = @firm
   #   @user.save!
   # end

    respond_to do |format|
      if @firm.save
        @user.save!
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
    klass=class_string_name
    contact =klass.constantize_with_care(Contact::TYPES).new(class_string_name)
    #contact = class_string_name.constantize.new
    
    puts " FIRST NAME: " + @user.first_name

    contact.first_name = @user.first_name
    contact.last_name = @user.last_name
    contact.user = @user
    contact.firm = @firm
    contact.save! 
  end
end

# Security vulnerability fix where constantize can be injected and changed through urls; http://blog.littleimpact.de/index.php/2008/08/13/constantize-with-care/
class String
  def constantize_with_care(list_of_klasses=[])
    list_of_klasses.each do |klass|
      return self.constantize if self == klass.to_s
    end
    raise "I'm not allowed to constantize #{self}!"
  end
end
