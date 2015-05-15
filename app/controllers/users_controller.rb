class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:save_google_oauth]
  before_filter :update_last_sign_in_at
  after_action :verify_authorized, except: [:show,:save_google_oauth, :select_calendar, :send_feedback_clean]
  require 'google/api_client'
  require 'google/api_client/client_secrets'
  require 'google/api_client/auth/installed_app'

  def index
    @users = User.all
    @firm = current_user.firm
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    if params[:google_auth]
      @calendars = @user.google_calendars
    end
    #p "CALENDARS ---------------> " + @calendars.to_s
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])  
    authorize @user
    if @user.update_attributes(secure_params)
      update_contact_user(@user)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def start_google_oauth
    @user = User.find(params[:id])
  end

  def save_google_oauth
    if params[:error].present?
      redirect_to root_path, notice: "Google Access Denied"
    else
      create_google_oauth
      sync_param = params[:state]
      if sync_param == "calendar"
        GoogleCalendars.get_calendars_list(current_user)
        redirect_to root_path({id: current_user.id, google_auth: true}), notice: "Calendars successfully imported"
      elsif sync_param == "contacts"
        contacts = GoogleContacts.contacts(current_user)
        redirect_to root_path, notice: "Contacts successfully imported"
      end
    end
  end

  def fail_google_oauth
    redirect_to root_path, notice: "Google Authentification Failed"
  end

  def import_contacts
    @user = current_user
    create_google_oauth if @user.oauth_token.blank?
    contacts = GoogleContacts.contacts(@user)
    logger.info "contacts: #{contacts.ai}\n\n\n"
    message = @user.errors.present? ? {error: @user.errors.full_messages.to_sentence} : {notice: 'Contacts were successfully imported.'}
    redirect_to root_path, :flash => message
  end

  def send_feedback_clean
    options = {
        user: current_user,
        email: params[:email],
        message: params[:message]
    }
    UserEmails.user_feedback(options).deliver
    render :nothing => true, :status => 200
  end

  protected

  def update_last_sign_in_at
    if user_signed_in? && !session[:logged_signin]
      sign_in(current_user, :force => true)
      session[:logged_signin] = true
    end
  end

  private

  def update_contact_user(user_)
    #puts "UPDATING USER --------------------------------- " + user_.inspect
    contact = user_.contact_user
    if (user_.role == "admin" || user_.role == "attorney") && contact.type != "Attorney"
     # puts "ATTORNEYYYYYYYYYYYYYYYYYYYYYYY BEFORE" + contact.inspect
      contact_user = contact.becomes!(Attorney)
      contact_user.user_account = user_
      contact_user.save!
      #puts "ATTORNEYYYYYYYYYYYYYYYYYYYYYYY AFTER" + user_.contact_user.inspect
    elsif @user.role == "staff" && contact.type != "Staff"
      #puts "STAFFFFFFFFFFFFFFFFFFFFFFFFFFF BEFORE" + contact.inspect  
      contact_user = contact.becomes!(Staff)
      contact_user.user_account = user_
      contact_user.save!
      #puts "STAFFFFFFFFFFFFFFFFFFFFFFFFFFF AFTER" + user_.contact_user.inspect  
    end
  end

  def secure_params
    params.require(:user).permit(:role, :time_zone, :event_ids => [])
  end

  def create_google_oauth
    logger.info "current_user: #{current_user.inspect}\n"
    logger.info "@auth: #{request.env["omniauth.auth"]["credentials"]}\n\n\n"
    @auth = request.env["omniauth.auth"]
    @token = @auth["credentials"]["token"]
    @refresh_token = @auth["credentials"]["refresh_token"]
    @expires_at = DateTime.strptime(@auth['credentials']['expires_at'].to_s,'%s')
    current_user.oauth_token = @token
    current_user.oauth_refresh_token = @refresh_token
    current_user.oauth_expires_at = @expires_at
    current_user.google_email = @auth['info']['email']
    current_user.save
  end

end
