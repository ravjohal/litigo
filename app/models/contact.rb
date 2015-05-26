class Contact < ActiveRecord::Base
  attr_encrypted :ssn, :key => 'zU8CYfjkHEQbghnwQzXeJA=='

  ATTORNEYS = ['Plaintiff', 'Defense', 'General Counsel', 'Co-counsel', 'Outside Counsel', 'Prosecution']

  TYPES = ['Attorney', 'Staff', 'Plaintiff', 'Defendant', 'Judge', 'Witness', 'Expert', 'Physician', 'Adjuster', 'General', 'Company']
  has_many :event_attendees
	belongs_to :user #user that owns this contact, basically the one who created this contact, answers: who created this contact?
  belongs_to :event
  belongs_to :user_account, class_name: 'User', foreign_key: 'user_account_id' #associated contact of the user, answers: is this contact a user?
  belongs_to :firm
  belongs_to :company
  belongs_to :lead
  has_many :case_contacts, :dependent => :destroy
  has_many :cases, :through => :case_contacts

  # validates :phone_number, length: { maximum: 10 }
  # validates :fax_number, length: { maximum: 10 }

  def self.inherited(child)
    child.instance_eval do
      def model_name
        Contact.model_name
      end
    end
    super
  end

  def name
    if self.type == "Company"
 #     puts "ARE WE IN COMPANY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
      self.company_name
    else
      if self.first_name.blank? && self.last_name.blank?
        self.email
      else
        "#{self.first_name.present? ? self.first_name : ''} #{self.last_name.present? ? self.last_name : ''}"
      end
    end
  end

  def tooltip
    if self.phone_number.present? || self.mobile.present? || self.email.present?
      p = self.phone_number.present? ? "P: #{self.phone_number}<br/>" : ''
      m = self.mobile.present? ? "M: #{self.mobile}<br/>" : ''
      e = self.email.present? ? "#{self.email}" : ''
      return p+m+e
    end
  end
end
