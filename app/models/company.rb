class Company < ActiveRecord::Base
	has_many :medical_bills
	has_many :contacts
	belongs_to :firm
	belongs_to :user

	accepts_nested_attributes_for :contacts, :reject_if => :all_blank
end
