class UserEmails < ActionMailer::Base
  def invite_existing_user(options)
    @send_to = options[:user][:email]
    @user = options[:user]
    @admin = options[:admin]
    @token = options[:token]
    @role = options[:role]
    mail(to: @send_to,
         from: "\"Litigo\" <ben@litigo.co>",
         subject: "Invitation instructions",
         content_type: "text/html") unless Rails.env.test?
  end
end
