class UserSignedUpNotifier < ActionMailer::Base
  default from: "litigoinsights@gmail.com"

  def send_notification(user)
    @user = user
    mail( :to => (Rails.env.production? ? "ben@litigo.co" : "litigoinsights@gmail.com"),
    :subject => @user.name + ' (' + @user.email + ')' + ' just signed up on Litigo!' )
  end
end
