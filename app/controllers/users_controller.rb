class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:save_google_oauth]
  before_filter :update_last_sign_in_at
  after_action :verify_authorized, except: [:show,:save_google_oauth, :select_calendar]
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
    create_google_oauth
    GoogleCalendars.get_calendars_list(current_user)
    #getting google contacts
    redirect_to user_path({id: current_user.id, google_auth: true})
  end

  def select_calendar
    if params[:select_calendar].present?
      params[:select_calendar].each do |calendar_id, val|
        if val == '1'
        GoogleCalendars.get_events(current_user, calendar_id.to_s)
        end
      end
    end
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

  def secure_params
    params.require(:user).permit(:role, :time_zone, :event_ids => [])
  end

  def create_google_oauth
    @auth = request.env["omniauth.auth"]
    @token = @auth["credentials"]["token"]
    @refresh_token = @auth["credentials"]["refresh_token"]
    @expires_at = DateTime.strptime(@auth['credentials']['expires_at'].to_s,'%s')
    logger.info "@auth: #{request.env["omniauth.auth"]["credentials"]}\n\n\n"
    current_user.oauth_token = @token
    current_user.oauth_refresh_token = @refresh_token
    current_user.oauth_expires_at = @expires_at
    current_user.google_email = @auth['info']['email']
    current_user.save
  end

end
