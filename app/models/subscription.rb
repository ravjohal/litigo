class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :email

  def cancel_plan(plan)
    customer = Stripe::Customer.retrieve(stripe_customer_token)
    subscription_token = customer.subscriptions.data.first["id"]
    subscription = customer.subscriptions.retrieve(subscription_token ).delete
    destroy!
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
    false
  end

  def change_subscription(new_plan)
    customer = Stripe::Customer.retrieve(stripe_customer_token)
    subscription_id = customer.subscriptions.data.first["id"]
    subscription = customer.subscriptions.retrieve(subscription_id)
    if new_plan.id == 4
      subscription.plan = "Basic-yr"
    else
      subscription.plan = new_plan.id.to_s
    end
    subscription.save
    update_attributes(:plan_id => new_plan.id)
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
    false
  end


  def save_with_payment(people_count, user)

    if valid?
      if plan_id == 4
        customer = Stripe::Customer.create(email: email, plan: "Basic-yr", source: stripe_card_token, quantity: people_count)
      else
        customer = Stripe::Customer.create(email: email, plan: plan_id, source: stripe_card_token, quantity: people_count)
      end
      self.stripe_customer_token = customer.id
      self.user_id = user.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
