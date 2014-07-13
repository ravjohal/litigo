class Contact < ActiveRecord::Base
	belongs_to :contactable, :polymorphic => true

	validates :contactable_type, :presence => true
	validates_presence_of :first_name, :last_name, :contactable_type
  validates :phone_number, length: { maximum: 10 }
  validates :fax_number, length: { maximum: 10 }

end
