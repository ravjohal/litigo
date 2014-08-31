class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_tenant #, :set_firm

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def after_sign_in_path_for(resource)
    user_root_path(resource)
  end

  def set_tenant
    if current_user
      if current_user.firm
        #firm_name = current_user.firm.name.gsub(/[^0-9a-z ]/i, '').tr(" ", "_")
        tenant = current_user.firm.tenant
        puts "FIRM SIGN IN: " + tenant
        Apartment::Tenant.switch(tenant)
      end
    end
  end

  def set_user
    @user = current_user
  end

  def set_firm
    if current_user
      @firm = current_user.firm
    end
  end

end
