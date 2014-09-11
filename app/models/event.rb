class Event < ActiveRecord::Base
	has_and_belongs_to_many :users #invitees
	#has_and_belongs_to_many :attorneys
	has_and_belongs_to_many :cases
	has_many :contacts
	belongs_to :owner, class_name: "User"

end
