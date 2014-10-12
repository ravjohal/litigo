class Medical < ActiveRecord::Base
	
	store_accessor :data, :doctor_type, :treatment_type

	belongs_to :case
	has_many :injuries, dependent: :destroy
	belongs_to :firm

	accepts_nested_attributes_for :injuries, :allow_destroy => true
end
