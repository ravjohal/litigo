class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_tenant #, :set_firm
  around_filter :set_time_zone

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name]
  end

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def toast(type, text)
  flash[:toastr] = { type => text }
  end

  def after_sign_in_path_for(resource)
    user_root_path(resource)
  end

  def set_tenant
    if current_user
      if current_user.firm
        #firm_name = current_user.firm.name.gsub(/[^0-9a-z ]/i, '').tr(" ", "_")
        tenant = current_user.firm.tenant
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

  def get_case #for nested resources
    if params[:case_id]
      @case = Case.find(params[:case_id])
    end
  end

  def create_contact(type, user_, firm_)
    klass = type
    hash_ = {:type => type} #need to pass in hash for new method
    puts "HASH =====>> " + hash_.inspect
    contact = klass.constantize_with_care(Contact::TYPES).new(hash_)
    contact.first_name = user_.first_name
    contact.last_name = user_.last_name
    contact.user = user_
    contact.firm = firm_
    contact.contact_user_id = user_.id
    contact.save!
  end

  def restrict_access(where_to)
    case where_to
    when "cases"
      redirect_to cases_path, :alert => "Please choose a case that belongs to you"
    when "contacts"
      redirect_to contacts_path, :alert => "Please choose a contact that belongs to you"
    when "documents"
      redirect_to documents_path, :alert => "Please choose a document that belongs to you"
    when "events"
      redirect_to events_path, :alert => "Please choose an event that belongs to you"
    when "notes"
      redirect_to notes_path, :alert => "Please choose a note that belongs to you"
    when "tasks"
      redirect_to tasks_path, :alert => "Please choose a task that belongs to you"
    else
      redirect_to root_path, :alert => "Access denied"
    end
  end

end
