class Attorney < ActiveRecord::Base
	has_one :contact, as: :contactable, dependent: :destroy
	has_many :events

	accepts_nested_attributes_for :contact
end
