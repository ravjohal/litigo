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

    ns = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, inbox_token)
    calendars = ns.calendars.all
    ns_account = ns.account
    namespace = Namespace.find_or_initialize_by(user_id: @user.id, namespace_id: ns_account.id, firm_id: @firm.id)
    namespace.update(account_id: ns_account.id, email_address: ns_account.email_address, name: ns_account.name, provider: ns_account.provider,
                     inbox_token: inbox_token, enabled: true)
    calendars.each do |nc|
      calendar = Calendar.find_or_initialize_by(namespace_id: namespace.id, calendar_id: nc.id, firm_id: @firm.id)
      calendar.update(description: nc.description, name: nc.name, nylas_namespace_id: nc.account_id, deleted: false)
    end
    redirect_to namespaces_path
  end

  private
  def set_inbox
    @inbox = Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, nil)
  end
end
