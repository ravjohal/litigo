class Medical < ActiveRecord::Base
	belongs_to :case
	has_many :injuries, dependent: :destroy
end
