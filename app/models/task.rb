class Task < ActiveRecord::Base
	has_and_belongs_to_many :cases
	has_one :user
end
