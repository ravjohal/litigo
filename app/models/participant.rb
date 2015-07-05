class Participant < ActiveRecord::Base
  has_many :event_participants, :dependent => :destroy
  has_many :events, :through => :event_participants
end