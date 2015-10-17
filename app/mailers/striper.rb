class Striper < ActionMailer::Base

  def change_subscription(subscription)
    @subscription = subscription
    mail(:to => subscription.email, :subject => "New Subscription Plan", :from => "litigoinsights@gmail.com")
  end

  def invoice_payment_failed(subscription)
    @subscription = subscription
    mail(:to => subscription.email, :subject => "Payment failed", :from => "litigoinsights@gmail.com")
  end

  def invoice_succeed(subscription)
    @subscription = subscription
    mail(:to => subscription.email, :subject => "Payment succeeded", :from => "litigoinsights@gmail.com")
  end
end