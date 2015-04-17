class Medical < ActiveRecord::Base
	
	DOCTOR_TYPE = ['MD', 'DO', 'Specialist', 'Other']
	TREATMENT_TYPE = ['PT', 'Chiro', 'Meds', 'Other']

	belongs_to :case
	has_many :injuries, dependent: :destroy
	has_many :medical_lines, dependent: :destroy
	belongs_to :firm

	accepts_nested_attributes_for :injuries, :allow_destroy => true
	accepts_nested_attributes_for :medical_lines, :allow_destroy => true
end
