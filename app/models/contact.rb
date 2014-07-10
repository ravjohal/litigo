class Contact < ActiveRecord::Base
	belongs_to :contactable, :polymorphic => true

	validates :contactable_type, :presence => true
end
