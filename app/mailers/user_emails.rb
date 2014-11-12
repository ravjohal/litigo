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

  def event_invitation(options)
    @user = options[:user]
    @send_to_contact = options[:send_to_contact]
    @contacts = options[:contacts]
    @event = options[:event]
    from = @user.name.present? ? "\"#{@user.name}\" <#{@user.email}>" : @user.email
    mail(to: @send_to_contact.email,
         from: from,
         subject: "Litigo Event Invitation",
         content_type: "text/html") unless Rails.env.test? || @send_to_contact.email.include?("gmail.com")
  end
end
