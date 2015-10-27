class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm

  def index
    @from_time = Time.now
    @activities = Activity.where(:firm_id => current_user.firm.id).order(:created_at => 'desc').limit(10)
  end

  private

  def case_params
    params.require(:activity).permit(:user_id, :trackable_id, :trackable_type, :action, :firm_id)
  end

end
