class Case < ActiveRecord::Base

	has_one :attorney, :through => :contact
	has_one :client, :through => :contact

	validates :number, :presence => true
	validates :case_type, :presence => true
	validates :subtype, :presence => true
end
