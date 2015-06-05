class NylasController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm, :set_inbox

  def login
    callback_url = url_for(:action => 'login_callback')
    redirect_to @inbox.url_for_authentication(callback_url, '')
  end

  def login_callback
    inbox_token = @inbox.token_for_code(params[:code])
    session[:inbox_token] = inbox_token

    @inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, inbox_token)
    ns = @inbox.namespaces.first
    calendars = ns.calendars.all
    namespace = Namespace.find_or_initialize_by(user_id: @user.id, namespace_id: ns.namespace_id)
    namespace.update(account_id: ns.account_id, email_address: ns.email_address, name: ns.name, provider: ns.provider,
                     inbox_token: inbox_token)
    calendars.each do |nc|
      calendar = Calendar.find_or_initialize_by(namespace_id: namespace.id, calendar_id: nc.id)
      calendar.update(description: nc.description, name: nc.name, nylas_namespace_id: nc.namespace_id)
    end
    redirect_to namespaces_path
  end

  private
  def set_inbox
    @inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, nil)
  end
end
