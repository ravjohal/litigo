class Company < ActiveRecord::Base
	belongs_to :medical_line
	has_many :contacts
	belongs_to :firm
end
