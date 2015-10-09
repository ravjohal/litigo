class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
  end

  def create
    user = current_user
    @subscription = Subscription.new(subscription_params)
    price = @subscription.plan.price.to_i
    count_people = @firm.users.count.to_i
    if @subscription.save_with_payment(price, count_people, user )
      redirect_to plans_path, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
private
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
  def subscription_params
    params.require(:subscription).permit(:plan_id, :user_id, :email, :stripe_customer_token,:stripe_card_token, :created_at, :updated_at )
  end
end