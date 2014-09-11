class Contact < ActiveRecord::Base
	#belongs_to :contactable, :polymorphic => true, :foreign_key => :contactable_id
  belongs_to :case
	belongs_to :user
  belongs_to :event
  belongs_to :user_account, class_name: "User"

  validates :type, presence: true
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

end
