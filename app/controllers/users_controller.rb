class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :update_last_sign_in_at
  after_action :verify_authorized, except: [:show,:save_google_oauth]

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
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
    current_user.oauth_token = request.env['omniauth.auth']['credentials']['token']
    current_user.oauth_expires_at = DateTime.strptime(request.env['omniauth.auth']['credentials']['expires_at'].to_s,'%s')
    current_user.save
    #binding.pry

    # RestClient.get('https://www.google.com/m8/feeds/contacts/russellsavage%40gmail.com/full?alt=json', {:content_type => :json, :authorization => 'Bearer ya29.QQCs5FjfrU5h3xoAAABi7y_JsdP1TTGpAb45n_3DCUYEvvZ1vxad7GVD8HvDsw'})
    redirect_to user_path(current_user.id)
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
    params.require(:user).permit(:role)
  end

end
