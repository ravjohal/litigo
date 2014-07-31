class Task < ActiveRecord::Base
	has_and_belongs_to_many :cases
	belongs_to :user
end
