class EventAttendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :contact

  validates :event_id, :uniqueness => {:scope => [:contact_id]}
end
