class Firm < ActiveRecord::Base
	has_many :users
	has_many :cases
	has_many :contacts
	has_many :documents
	has_many :events
	has_many :incidents
	has_many :medicals
	has_many :injuries
	has_many :notes
	has_many :tasks
	has_many :treatments
	has_many :resolutions

	validates_presence_of :name
end
