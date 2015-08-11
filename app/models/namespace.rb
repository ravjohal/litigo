class Namespace < ActiveRecord::Base
  belongs_to :user
  belongs_to :firm
  has_many :calendars, :dependent => :destroy
  has_many :events, :dependent => :destroy
  SYNC_PERIODS = {'3' => 'Sync last 3 months', '6'=> 'Sync last 6 months', '12' => 'Sync Last year', '0' => 'Sync all calendar events'}

  include ActiveCalendars

  before_destroy :delete_from_nylas

  # @return [Inbox::Api]
  def nylas_inbox
    @nylas_api ||= Inbox::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, inbox_token)
  end

  # @return [Inbox::RestfulModel]
  def nylas_namespace
    @nylas_namespace ||= nylas_inbox.namespaces.first
  end

  def nylas_account
    @nylas_account ||= nylas_inbox.accounts.first
  end

  def full_name
    name.present? ? "#{name}/#{provider}" : email_address
  end

  private

    def delete_from_nylas
      nylas_account.destroy rescue nil
      nylas_namespace.destroy rescue nil
    end
end