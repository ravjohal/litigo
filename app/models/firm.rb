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
	has_many :resolutions
	has_many :google_calendars

	validates_presence_of :name
	validates_uniqueness_of :name

  accepts_nested_attributes_for :users
end
