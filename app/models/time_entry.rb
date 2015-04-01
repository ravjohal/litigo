class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :case
  has_one :firm
  CHARGE_TYPES = ['hourly', 'fixed fee', 'contingent', 'no charge', 'non-billable']
end
