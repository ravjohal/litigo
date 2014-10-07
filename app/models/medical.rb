class Medical < ActiveRecord::Base
	belongs_to :case
	has_many :injuries, dependent: :destroy
	belongs_to :firm

	accepts_nested_attributes_for :injuries, :allow_destroy => true
end
