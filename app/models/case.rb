class Case < ActiveRecord::Base

	validates :number, :presence => true
	validates :case_type, :presence => true
	validates :subtype, :presence => true
end
