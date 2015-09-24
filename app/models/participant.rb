class Participant < ActiveRecord::Base
  has_many :event_participants, :dependent => :destroy
  has_many :events, :through => :event_participants
  belongs_to :firm

  after_save :load_into_soulmate

  def load_into_soulmate
    return if email.blank?
    loader = Soulmate::Loader.new("contact-#{firm_id}")
    loader.add('term' => email, 'id' => "participant-#{id}")
  end

end