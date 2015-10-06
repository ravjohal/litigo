class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  
  def new
    @from_time = Time.now
    @notifications = Notification.where(user_id: current_user.id).order(created_at: :desc)
    update_notification_flag
    @lead = Lead.new
    if current_user.firm && current_user.finish?
      current_user.create_contact User::USER_ROLES[current_user.invitation_role.to_i].to_s.humanize unless current_user.contact_user
      # if params[:google_auth]
      #   @calendars = @user.google_calendars
      # end
      #p "CALENDARS ---------------> " + @calendars.first.summary.to_s
      render :show
    else
      @firm = current_user.firm || Firm.new
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

  def save_step
    @user.confirm_step = params[:step]
    if @user.save
      render nothing: true, :status => :ok
    else
      render nothing: true, :status => :unprocessable_entity
    end
  end

  def finish_registration
    redirect_to dashboards_path, notice: 'Firm and Contact were successfully created.'
  end

  def create

    time_zone = params[:firm][:user][:time_zone]
    firm_name = params[:firm][:name]
    is_new = true
    if @user.firm
      @firm = @user.firm
      is_new = false
    else
      # firm_from_db = Firm.find_by(:name => firm_name)
      # if !firm_from_db
      @firm = Firm.new
      # else
      #   @firm = firm_from_db
      #   @user.firm = @firm
      #   @user.save!
      # end
      @user.firm = @firm
      @user.role = :admin
    end

    tenant = firm_name.gsub(/[^0-9a-z ]/i, '').tr(' ', '_') #replace whitespace and remove special characters
    @firm.name = firm_name
    @firm.phone = params[:firm][:phone]
    #@firm.zip = params[:zip]
    @firm.tenant = tenant

    @user.time_zone = time_zone

    if @firm.save
      @user.save!
      UserSignedUpNotifier.send_notification(@user).deliver if is_new
      create_contact_from_parms if Contact.where(user_account_id: @user.id, email: @user.email).count < 1
      if request.xhr?
        render nothing: true, :status => 200
      else
        redirect_to dashboard_path(@user), notice: 'Firm and Contact were successfully created.'
      end
      #format.json { render :show, status: :created, location: @firm }
    else
      if request.xhr?
        render nothing: true, status: :unprocessable_entity
      else
        render :new
      end
      #format.json { render json: @firm.errors, status: :unprocessable_entity }
    end
  end

  private
  def update_notification_flag
    @notifications.each do |note|
      note.update_attribute(:is_read, true)
    end
  end

  def create_contact_from_parms
    # contact = Contact.new
    class_string_name = params[:firm][:contact][:type].to_s

    if class_string_name == "Staff/Paralegal"
      class_string_name = "Staff"
    end
    @user.create_contact(class_string_name, @firm)
  end
end