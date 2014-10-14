class Medical < ActiveRecord::Base
	
	DOCTOR_TYPE = ['MD', 'Specialist', 'DO', 'Other']
	TREATMENT_TYPE = ['PT', 'Chiro', 'Meds', 'Other']

	store_accessor :data, :doctor_type, :treatment_type

	belongs_to :case
	has_many :injuries, dependent: :destroy
	belongs_to :firm

	accepts_nested_attributes_for :injuries, :allow_destroy => true
end
