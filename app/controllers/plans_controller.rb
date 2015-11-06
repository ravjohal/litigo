class PlansController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_user, :set_firm

  def index
    @own_subscription = current_user.subscriptions.last
    @plans = Plan.where('id = ? or id = ? or id = ?', 1, 4, 5).order('price')   # for now we need only basic plans(1,4 -ids) and 5 - free plan
    @user_id = params[:user_id]

    render layout: 'only_content' if params[:only_content]
  end

  def plan_params
    params.require(:plan).permit(:name, :price, :price_description, :created_at, :updated_at )
  end
end