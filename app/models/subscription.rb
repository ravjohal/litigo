class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user

  validates_presence_of :email

  attr_accessor :stripe_card_token

  def cancel_plan(plan)
    customer = Stripe::Customer.retrieve(stripe_customer_token)
    subscription_token = customer.subscriptions.data.first["id"]
    subscription = customer.subscriptions.retrieve(subscription_token ).delete
    update_attributes(:plan_id => nil)
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while canceling subscription plan: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
    false
  end

  def change_subscription(count_people, new_plan)
    customer = Stripe::Customer.retrieve(stripe_customer_token)
    subscription_id = customer.subscriptions.data.first["id"]
    subscription = customer.subscriptions.retrieve(subscription_id)
    if new_plan.id == 4
      subscription.plan = "Basic-yr"
    else
      subscription.plan = new_plan.id.to_s
    end
    subscription.quantity = count_people
    subscription.save
    update_attributes(:plan_id => new_plan.id)
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while changing subscription: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
    false
  end

  def create_subscription_without_customer(count_people, new_plan)
    customer = Stripe::Customer.retrieve(stripe_customer_token)

    if new_plan.id == 4
      customer.subscriptions.create(:plan => "Basic-yr", :quantity => count_people)
    else
      customer.subscriptions.create(:plan => new_plan.id.to_s, :quantity => count_people)
    end
    update_attributes(:plan_id => new_plan.id)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while changing subscription: #{e.message}"
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
      self.last_digits = customer.sources.data.first["last4"]
      self.user_id = user.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_card(subscriber)
    customer = Stripe::Customer.retrieve(subscriber.stripe_customer_token)
    card = customer.sources.create(source: stripe_card_token)
    card.save
    customer.default_card = card.id
    customer.save
    last_digits = customer.sources.data.first["last4"]
    update_attributes(:last_digits => last_digits)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while updating card info: #{e.message}"
    errors.add :base, "#{e.message}"
    false
  end

end
