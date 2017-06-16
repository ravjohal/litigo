class Lead < ActiveRecord::Base
  belongs_to :screener, class_name: 'User', :foreign_key => 'screener_id'
  belongs_to :attorney, class_name: 'User', :foreign_key => 'attorney_id'
  belongs_to :firm

  has_one :event
  has_one :case
  has_one :contact #the contact that gets created once lead has been assigned to a case
  belongs_to :referring_contact, class_name: 'Contact', :foreign_key => 'referring_contact_id'
  has_many :documents
  has_many :notifications, as: :notificable

  CHANNELS = ['Internet', 'Phone book', 'Prior Client', 'Radio', 'Referral - TSMS', 'Referral - Doctor', 'Referral - Attorney', 'Referral - Client', 'Referral', 'Television', 'Other']
  STATUS = {
      pending_review: 'New Lead - Pending Review',
      outside_action: 'Outside Action Needed to Proceed',
      appointment_scheduled: 'Appt. Scheduled',
      rejected: 'Rejected',
      accepted: 'Accepted',
      inactive: 'Inactive',
      declined: 'Client Declined',
      referred: 'Referred'
  }

  include PgSearch
  pg_search_scope :search_lead, against: [:first_name, :last_name, :estimated_value, :status],
                  using: {tsearch: {dictionary: :english, prefix: true}},
                  associated_against: { :screener => [:name, :email]  }

  def name
    "#{first_name} #{last_name}"
  end

  def case_type_sub_type
    if case_type && sub_type
      self.case_type + ": " + self.sub_type
    elsif case_type && !sub_type
      self.case_type
    elsif sub_type && !case_type
      self.sub_type
    else
      ""
    end
  end
  

  def generate_case_attrs(user)
    {
        :name => "#{last_name}, #{first_name}",
        :case_number => Case.increment_number(firm, 'accept_case', nil),
        :case_type => case_type,
        :subtype => sub_type,
        :firm_id => firm_id,
        :user_id => user.id,
        :description => case_summary,
        :status => 'Active',
        state: state,
        :medical_attributes => {
            :firm_id => firm_id,
            :hospitalization => hospitalized,
            :injuries_attributes => [{
                                          :injury_type => primary_injury,
                                          :region => primary_region,
                                          :firm_id => firm_id,
                                          :primary_injury => true
                                      }]
        },
        incident_attributes: {
            :incident_date => incident_date,
            :firm_id => firm_id,
            :user_id => user.id
        },
        :notes_attributes => [{
                                   :note => note,
                                   :firm_id => firm_id,
                                   :user_id => user.id,
                                   :author => user.name,
                                   :note_type => 'Status'
                               }],
        # "contacts_attributes" => [{
        #                               "type" => 'Plaintiff',
        #                               "first_name" => self.first_name,
        #                               "last_name" => self.last_name,
        #                               "address" => self.address,
        #                               "city" => self.city,
        #                               "state" => self.state,
        #                               "zip_code" => self.zip_code,
        #                               "email" => self.email,
        #                               "phone_number" => self.phone,
        #                               "date_of_birth" => self.dob,
        #                               "encrypted_ssn" => self.ssn,
        #                               "firm_id" => self.firm_id,
        #                               "user_id" => user.id
        #                           }]
    }
  end

  def self.active_leads_scope
    where(status: ['pending_review', 'appointment_scheduled', 'outside_action'])
  end

  def self.accepted_leads_scope
    where(status: 'accepted')
  end

  def self.rejected_leads_scope
    where(status: ['rejected', 'declined'])
  end

  def self.inactive_leads_scope
    where(status: 'inactive')
  end


  def self.referred_leads_scope
    where(status: 'referred')
  end

  def exist_event?
    Event.where(:lead_id => id).exists? if id
  end
end
