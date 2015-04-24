class Medical < ActiveRecord::Base
	
	DOCTOR_TYPE = ['MD', 'DO', 'Specialist', 'Other']
	TREATMENT_TYPE = ['PT', 'Chiro', 'Meds', 'Other']

	belongs_to :case
	has_many :injuries, dependent: :destroy
	has_many :medical_bills, dependent: :destroy
	belongs_to :firm
	belongs_to :user

	accepts_nested_attributes_for :injuries, :allow_destroy => true
	accepts_nested_attributes_for :medical_bills, :reject_if => :all_blank, :allow_destroy => true
end
