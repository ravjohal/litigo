class GoogleCalendar < ActiveRecord::Base
  belongs_to :user
  belongs_to :firm
end
