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

  def save_with_payment(charge, people_count, user)
    @amount = charge * people_count * 100
    if valid?
      if plan_id == 4
        customer = Stripe::Customer.create(email: email, plan: "Basic-yr", source: stripe_card_token, quantity: people_count)
      else
        customer = Stripe::Customer.create(email: email, plan: plan_id, source: stripe_card_token, quantity: people_count)
      end
      self.stripe_customer_token = customer.id
      self.user_id = user.id
      save!

      charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount.to_i,
          :description => 'Rails Stripe customer',
          :currency    => 'usd'
      )
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
