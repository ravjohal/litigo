class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :firm
	belongs_to :task
	belongs_to :calendar
	belongs_to :namespace
  has_many :event_participants, :dependent => :destroy
  has_many :participants, :through => :event_participants

  attr_accessor :start_date, :start_time, :end_date, :end_time
  validates_presence_of :starts_at, :ends_at
  validate :end_after_start

  def end_after_start
    if self.starts_at.present? && self.ends_at.present? && self.ends_at < self.starts_at
      errors.add(:starts_at, "Date Later Than End Date")
    end
  end

end
