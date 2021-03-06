class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  before_action :set_subscription, only: [:show, :edit, :update_plan,:edit_card, :update, :change_plan,  :destroy]
  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
    @subscription.email = User.select(:email).where(id: params[:user_id]).first.email if params[:user_id]
  end

  def create
    user = current_user
    count_people = @firm.users.count.to_i
    @subscription = Subscription.new(subscription_params)
    if @subscription.save_with_payment(count_people, user )
      redirect_to plans_path, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def change_plan
    count_people = @firm.users.count.to_i
    plan = Plan.find(params[:plan_id])
    @subscription = current_user.subscriptions.last
    if @subscription.plan_id != nil
      if @subscription.change_subscription(count_people, plan)
        redirect_to plans_path, :notice => "Plan succesfuly changed!"
      else
        render :new
      end
    else
      if @subscription.create_subscription_without_customer(count_people, plan)
        redirect_to plans_path, :notice => "Thank you for subscribing!"
      else
        render :new
      end
    end
  end

  def edit_card
  end

  def update
    if @subscription.update(subscription_params)
      if @subscription.update_card(@subscription)
        redirect_to @subscription,  :notice => "Saved. Your card information has been updated."
      else
        redirect_to @subscription, :notice => "Stripe reported an error while updating your card. Please try again."
      end
    end
  end

  def destroy
    plan = @subscription.plan_id
    if @subscription.cancel_plan(plan)
      redirect_to plans_path, :notice => "Your subscription has been canceled"
    else
      render :new
    end
  end

  def show
    @own_subscription = current_user.subscriptions.last
  end
private
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
  def subscription_params
    params.require(:subscription).permit(:plan_id, :user_id, :email, :last_digits, :stripe_customer_token,:stripe_card_token, :created_at, :updated_at )
  end
end