class EventParticipant < ActiveRecord::Base
  belongs_to :event
  belongs_to :participant
  validates_uniqueness_of :event_id, :scope => :participant_id
  belongs_to :firm
end