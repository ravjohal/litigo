class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  
  def new
    @lead = Lead.new
    if current_user.firm
      current_user.create_contact User::USER_ROLES[current_user.invitation_role.to_i].to_s.humanize unless current_user.contact_user
      # if params[:google_auth]
      #   @calendars = @user.google_calendars
      # end
      #p "CALENDARS ---------------> " + @calendars.first.summary.to_s
      render :show
    else
      @firm = Firm.new
    end
  end

  def show
  end

  def select_calendar
    if params[:select_calendar].present?
      params[:select_calendar].each do |calendar_id, val|
        if val == '1'
          GoogleCalendars.get_events(current_user, calendar_id.to_s)
        elsif val == '0'
          GoogleCalendar.find_by(user_id: @user.id, google_id: calendar_id).destroy
        end
      end
    end
    respond_to do |format|
      format.json { render :json => { success: true } }
    end
  end

  def create
    time_zone = params[:firm][:user][:time_zone]
    firm_name = params[:firm][:name]
    firm_from_db = Firm.find_by(:name => firm_name)
    #if !firm_from_db
      @firm = Firm.new
      tenant = firm_name.gsub(/[^0-9a-z ]/i, '').tr(" ", "_") #replace whitespace and remove special characters
      @firm.name = firm_name
      @firm.phone = params[:phone]
      #@firm.zip = params[:zip]
      @firm.tenant = tenant

      @user.firm = @firm
      @user.role = :admin
      @user.time_zone = time_zone
   # else
   #   @firm = firm_from_db
   #   @user.firm = @firm
   #   @user.save!
   # end

    respond_to do |format|
      if @firm.save
        @user.save!
        UserSignedUpNotifier.send_notification(@user).deliver
        create_contact_from_parms if Contact.where(user_account_id: @user.id, email: @user.email).count < 1
        format.html { redirect_to dashboard_path(@user), notice: 'Firm and Contact were successfully created.' }
        #format.json { render :show, status: :created, location: @firm }
      else
        format.html { render :new }
        #format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_contact_from_parms
    # contact = Contact.new
    class_string_name = params[:firm][:contact][:type].to_s

    if class_string_name == "Staff/Paralegal"
      class_string_name = "Staff"
    end
    @user.create_contact(class_string_name, @firm)
  end
end