Stripe.api_key = ENV["Stripe_api_key"]
STRIPE_PUBLIC_KEY = ENV["STRIPE_PUBLIC_KEY"]

StripeEvent.configure do
  subscribe 'customer.subscription.updated' do |event|
    subscription = Subscription.find_by_stripe_customer_token(event.data.object.customer)
    Striper.change_subscription(subscription).deliver
  end

  subscribe 'invoice.payment_failed' do |event|
    subscription = Subscription.find_by_stripe_customer_token(event.data.object.customer)
    Striper.invoice_payment_failed(subscription).deliver
  end

  subscribe 'invoice.payment_succeeded' do |event|
    subscription = Subscription.find_by_stripe_customer_token(event.data.object.customer)
    Striper.invoice_succeed(subscription).deliver
  end

end

