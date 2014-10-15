class Contact < ActiveRecord::Base
	
  TYPES = ['Attorney', 'Client', 'Witness', 'Plaintiff', 'Defendant', 'Staff', 'General']

  belongs_to :case
	belongs_to :user
  belongs_to :event
  belongs_to :user_account, class_name: 'User'
  belongs_to :firm

	validates_presence_of :type
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, length: { maximum: 10 }
  validates :fax_number, length: { maximum: 10 }

  def self.search(search)
    if search
      where('lower(email) LIKE ?', "%#{search}%")
    else
      scoped
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
    first_name + " " + last_name
  end

end
