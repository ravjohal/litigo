class PlansController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_user, :set_firm

  def index
    @own_subscription = Subscription.where(:user_id => current_user).last
    @plans = Plan.order('price')
  end

  def plan_params
    params.require(:plan).permit(:name, :price, :price_description, :created_at, :updated_at )
  end
end