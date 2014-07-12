class Defendant < ActiveRecord::Base
	has_one :contact, as: :contactable, dependent: :destroy

	accepts_nested_attributes_for :contact
end
