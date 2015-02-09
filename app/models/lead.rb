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

  def generate_case_attrs(user)
    return {
        "name" => "#{self.last_name} dd #{self.incident_date}",
        "case_number" => Case.increment_number(firm, 'accept_case', nil),
        "case_type" => self.case_type,
        "subtype" => self.sub_type,
        "firm_id" => self.firm_id,
        "user_id" => user.id,
        "description" => self.case_summary,
        "status" => 'Negotiation',
        "medical_attributes" => {
            "firm_id" => self.firm_id,
            "hospitalization" => self.hospitalized,
            "injuries_attributes" => [{
                                          "injury_type" => self.primary_injury,
                                          "region" => self.primary_region,
                                          "firm_id" => self.firm_id,
                                          "primary_injury" => true
                                      }]
        },
        "incident_attributes" => {
            "incident_date" => self.incident_date,
            "police_report" => self.police_report,
            "insurance_provider" => self.lead_insurance,
            "firm_id" => self.firm_id,
            "policy_limit" => self.lead_policy_limit
        },
        "notes_attributes" => [{
                                   "note" => self.note,
                                   "firm_id" => self.firm_id,
                                   "user_id" => user.id,
                                   "author" => user.name,
                                   "note_type" => 'Status'
                               }],
        "contacts_attributes" => [{
                                      "type" => 'Plaintiff',
                                      "first_name" => self.first_name,
                                      "last_name" => self.last_name,
                                      "address" => self.address,
                                      "city" => self.city,
                                      "state" => self.state,
                                      "zip_code" => self.zip_code,
                                      "email" => self.email,
                                      "phone_number" => self.phone,
                                      "date_of_birth" => self.dob,
                                      "encrypted_ssn" => self.ssn,
                                      "firm_id" => self.firm_id,
                                      "user_id" => user.id
                                  }]
    }
  end
end
