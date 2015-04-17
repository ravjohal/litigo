class Company < ActiveRecord::Base
	belongs_to :medical_line
	belongs_to :contact
	belongs_to :firm
end
