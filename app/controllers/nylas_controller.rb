class NylasController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm

  def login
    inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, nil)
    # The email address of the user you want to authenticate
    user_email = 'answer2005@gmail.com'

    # This URL must be registered with your application in the developer portal
    callback_url = url_for(:action => 'login_callback')

    redirect_to inbox.url_for_authentication(callback_url, user_email)
  end

  def login_callback
    inbox = Inbox::API.new(config.inbox_app_id, config.inbox_app_secret, nil)
    inbox_token = inbox.token_for_code(params[:code])
    logger.info "inbox_token: #{inbox_token}\n\n\n"
    # Save the inbox_token to the current session, save it to the user model, etc.
  end
end
