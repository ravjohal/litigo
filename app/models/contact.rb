class Contact < ActiveRecord::Base
  attr_encrypted :ssn, :key => 'zU8CYfjkHEQbghnwQzXeJA=='

  ATTORNEYS = ['Plaintiff', 'Defense', 'General Counsel', 'Co-counsel', 'Outside Counsel', 'Prosecution']

  TYPES = ['Attorney', 'Adjuster', 'Plaintiff', 'Defendant', 'Staff', 'Judge', 'Witness', 'Expert', 'Physician', 'General']
  has_many :event_attendees
	belongs_to :user #user that owns this contact, basically the one who created this contact, answers: who created this contact?
  belongs_to :event
  belongs_to :user_account, class_name: 'User', foreign_key: 'user_account_id' #associated contact of the user, answers: is this contact a user?
  belongs_to :firm
  belongs_to :company
  has_many :case_contacts, :dependent => :destroy
  has_many :cases, :through => :case_contacts

  # validates :phone_number, length: { maximum: 10 }
  # validates :fax_number, length: { maximum: 10 }

  def type_with_spacing
    if self.type == 'ExpertWitness'
      "Expert Witness"
    else
      self.type
    end
  end

  def self.inherited(child)
    child.instance_eval do
      def model_name
        Contact.model_name
      end
    end
    super
  end

  def name
    "#{self.first_name.present? ? self.first_name : ''} #{self.last_name.present? ? self.last_name : ''}"
  end

end
