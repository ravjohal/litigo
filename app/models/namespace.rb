class Namespace < ActiveRecord::Base
  belongs_to :user
  belongs_to :firm
  has_many :calendars, :dependent => :destroy
  has_many :events, :dependent => :destroy
  SYNC_PERIODS = {'3' => 'Sync last 3 months', '6'=> 'Sync last 6 months', '12' => 'Sync Last year', '0' => 'Sync all calendar events'}

  # exclude all those in array, only need events for now
  NYLAS_EXCLUDE_DELTA = [Nylas::Tag, Nylas::Calendar, Nylas::Contact, Nylas::Message, Nylas::File, Nylas::Thread]

  scope :enabled, -> { where(:enabled => true) }
  scope :disabled, -> { where(:enabled => false) }

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
    @nylas_account ||= nylas_inbox.accounts.find(account_id)
  end

  def full_name
    name.present? ? "#{name}/#{provider}" : email_address
  end

  # @return [Integer] the last update of the namespace (to figure out the deltas)
  def nylas_cursor
    cursor.blank? ? nylas_namespace.get_cursor(last_sync.to_i) : cursor
  end

  def check_for_exists_in_nylas
    if inbox_token
      begin
        destroy if nylas_account && nylas_account0.billing_state.to_s == 'deleted'
      rescue Exception => _
      end
    end
  end

  def disable_nylas_account
    if nylas_account
      nylas_account.billing_state = 'deleted'
      nylas_account.save!
    end
  end

  def delayed_destroy
    self.enabled = false
    save ? Calendar.where(:namespace_id => id).update_all(:deleted => true, :active => false) : false
  end

  private

    def delete_from_nylas
      begin
        # disable_nylas_account
      rescue Exception => e
        a2 = 3
      end

      # nylas_account.destroy rescue nil
      # nylas_namespace.destroy rescue nil
    end
end