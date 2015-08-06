class Event < ActiveRecord::Base
	belongs_to :user, class_name: 'User', foreign_key: 'created_by'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
	belongs_to :firm
	belongs_to :task
	belongs_to :calendar
	belongs_to :namespace
  belongs_to :event_series
  has_many :event_participants, :dependent => :destroy
  has_many :participants, :through => :event_participants

  attr_accessor :start_date, :start_time, :end_date, :end_time, :recur, :period, :frequency, :recur_start_date, :recur_end_date, :update_all_events
  validates_presence_of :starts_at, :ends_at
  validate :end_after_start

  REPEATS = [
      "Daily"          ,
      "Weekly"         ,
      "Monthly"        ,
      "Yearly"
  ]

  def end_after_start
    if self.starts_at.present? && self.ends_at.present? && self.ends_at < self.starts_at
      errors.add(:starts_at, "Date Later Than End Date")
    end
  end

  def assign_participants(str, firm_id)
    if str.present?
      participants = str.split(",")
      participants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
        EventParticipant.create(event_id: self.id, participant_id: participant.id, firm_id: firm_id)
      end
    end
  end

  def updated_by
    User.find(self.last_updated_by)
  end

  def update_participants(str, firm_id)
    unless str.nil?
      participants = str.split(',')
      existed_participants = self.participants.map {|a| a.email}
      # event_participants = self.event_participants.to_a

      deleted_participiants = existed_participants - participants
      new_participiants = participants - existed_participants
      # common_participiants = participants & existed_participants

      new_participiants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
        EventParticipant.create(event_id: id, participant_id: participant.id, firm_id: firm_id)
      end

      deleted_participiants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
        EventParticipant.delete_all(event_id: id, participant_id: participant.id, firm_id: firm_id)
      end

      # participants.each do |p_email|
      #   participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
      #   event_participant = EventParticipant.find_or_create_by(event_id: self.id, participant_id: participant.id, firm_id: firm_id)
      #   event_participants.delete(event_participant)
      # end
      # event_participants.each {|ep| ep.destroy }
      self.event_participants.reload
      self.participants.reload
    end
  end
end
