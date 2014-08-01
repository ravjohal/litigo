class Event < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :attorneys
	has_and_belongs_to_many :cases
	belongs_to :owner, class_name: "User"

end
