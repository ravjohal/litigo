class Company < ActiveRecord::Base
	belongs_to :medical_bill
	has_many :contacts
	belongs_to :firm
end
