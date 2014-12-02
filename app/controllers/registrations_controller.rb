class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_devise_permitted_parameters, :only => [:create, :update]


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



  def settings
    @user = current_user
  end

  def profile
    @user = current_user
    @firm = @user.firm
  end

  def admin
    @user = current_user
    @firm = @user.firm
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :name, :email, :password, :password_confirmation, :time_zone, :role, :firm_attributes => [:name, :id, :phone]]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end
end
