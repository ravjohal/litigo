class Event < ActiveRecord::Base
	has_many :user_events, :dependent => :destroy
	has_many :users, :through => :user_events
	has_many :case_events, :dependent => :destroy
	has_many :cases, :through => :case_events
  has_many :event_attendees, :dependent => :destroy
	has_many :contacts, :through => :event_attendees

	belongs_to :owner, class_name: 'User', :foreign_key => 'owner_id'
	belongs_to :firm

  accepts_nested_attributes_for :user_events

  validates_presence_of :start, :end
  validate :end_after_start

  def end_after_start
    if self.start.present? && self.start.present? && self.end < self.start
      errors.add(:start, "Date Later Than End Date")
    end
  end

end
