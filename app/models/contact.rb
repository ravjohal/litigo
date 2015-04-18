class Contact < ActiveRecord::Base
  attr_encrypted :ssn, :key => 'zU8CYfjkHEQbghnwQzXeJA=='

  ATTORNEYS = ['Plaintiff', 'Defense', 'General Counsel', 'Co-counsel', 'Outside Counsel', 'Prosecution']

  TYPES = ['Attorney', 'Adjustor', 'Plaintiff', 'Defendant', 'Staff', 'Judge', 'Witness', 'General']
  has_many :event_attendees
	belongs_to :user
  belongs_to :event
  belongs_to :user_account, class_name: 'User'
  belongs_to :firm
  belongs_to :company

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
    first_name + " " + last_name if first_name.present? && last_name.present?
  end

end
