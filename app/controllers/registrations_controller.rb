class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_devise_permitted_parameters, :only => [:create, :update]


	def after_sign_up_path_for(resource)
   		onboarding_path
  	end

  	def create
  		super
  		resource.name = resource.first_name + " " + resource.last_name
  		resource.save!
  	end


  protected

  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :name, :email, :password, :password_confirmation]

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
end
