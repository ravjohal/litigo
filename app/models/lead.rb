class Lead < ActiveRecord::Base
  belongs_to :screener, class_name: 'User', :foreign_key => 'screener_id'
  belongs_to :attorney, class_name: 'User', :foreign_key => 'attorney_id'
  belongs_to :firm
  belongs_to :case
  STATUS = {pending_review: "New Lead - Pending Review", appointment_scheduled: "Appt. Scheduled", rejected: "Rejected", accepted: "Accepted", inactive: "Inactive"}

  include PgSearch
  pg_search_scope :search_lead, against: [:first_name, :last_name, :estimated_value, :status],
                  using: {tsearch: {dictionary: "english", prefix: true}},
                  associated_against: { :user => [:name, :email]  }

  def name
    return "#{self.first_name} #{self.last_name}"
  end
end
