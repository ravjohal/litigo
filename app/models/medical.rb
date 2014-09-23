class Medical < ActiveRecord::Base
	belongs_to :case
	has_many :injuries, dependent: :destroy

	accepts_nested_attributes_for :injuries, :allow_destroy => true
end
