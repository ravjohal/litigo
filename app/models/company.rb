class Company < ActiveRecord::Base
	has_many :medical_bills
	has_many :contacts
	belongs_to :firm
end
