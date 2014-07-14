class Event < ActiveRecord::Base
	has_many :users
	has_many :attorneys
	has_many :cases
end
