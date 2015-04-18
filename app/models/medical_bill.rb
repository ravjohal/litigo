class MedicalBill < ActiveRecord::Base
	belongs_to :user
	belongs_to :firm
	belongs_to :medical
	has_one :company
end
