class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_devise_permitted_parameters, :only => [:create, :update, :update_profile]


  def after_sign_up_path_for(resource)
    onboarding_path
  end

  def create
    super
    resource.name = resource.first_name + " " + resource.last_name
    resource.save
  end

  # def update
  #
  #   super
  # end

  def update
    unless current_user.admin?
      params[:user].delete :firm_attributes
      params[:user].delete :role
    end
    prev_unconfirmed_email = current_user.unconfirmed_email if current_user.respond_to?(:unconfirmed_email)

    user_updated = update_resource(current_user, account_update_params)
    yield current_user if block_given?
    if user_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(current_user, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, current_user, bypass: true
      respond_with after_update_path_for(current_user), location: after_update_path_for(current_user)
    else
      clean_up_passwords current_user
      redirect_to request.referrer, :flash => {:error => current_user.errors.full_messages.to_sentence}
    end
  end

  def destroy
    @firm = current_user.firm
    if current_user.admin?
      unless @firm.more_than_one_admin
        @firm.users.each do |user|
          user.delete
        end
        @firm.delete
        message = "Firm and all users deleted."
      end
    end

    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    #respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }

    redirect_to root_path, :notice => "Account has been canceled. " + message.to_s
  end

  def settings
    @user = current_user
  end

  def profile
    @user = current_user
    @firm = @user.firm
    if @user.admin? && !@firm.more_than_one_admin
      @confirm_message = "You are the only admin for firm: " + @firm.name + ". You sure you want to delete the account?  It will delete Firm and all users as well!"
    else
      @confirm_message = "Are you sure you want to cancel your account?"
    end
  end

  def admin
    @user = current_user
    @firm = @user.firm
  end

  def update_profile
    @user = current_user
    if @user.update_attributes(profile_update_params)
      redirect_to root_path, :notice => "Profile updated."
    else
      redirect_to request.referrer, :alert => @user.errors.full_messages.to_sentence
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    confirm_email_path
  end

  def configure_devise_permitted_parameters
    update_profile_params = [:first_name, :last_name, :email, :role, :firm_attributes => [:name, :id, :phone]]
    registration_params = [:first_name, :last_name, :name, :email, :password, :password_confirmation, :time_zone]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    elsif params[:action] == 'update_profile'
      devise_parameter_sanitizer.for(:update_profile) {
          |u| u.permit(update_profile_params)
      }
    end
  end

  def profile_update_params
    devise_parameter_sanitizer.sanitize(:update_profile)
  end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end
end
