class Namespace < ActiveRecord::Base
  belongs_to :user
  belongs_to :firm
  has_many :calendars, :dependent => :destroy
  SYNC_PERIODS = {'3' => 'Sync last 3 months', '6'=> 'Sync last 6 months', '12' => 'Sync Last year', '0' => 'Sync all calendar events'}

  def full_name
    name.present? ? "#{name}/#{provider}" : email_address
  end
end
