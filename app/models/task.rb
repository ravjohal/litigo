class Task < ActiveRecord::Base
	has_many :cases
	has_one :user
end
