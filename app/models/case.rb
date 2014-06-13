class Case < ActiveRecord::Base
	belongs_to :case_type
	belongs_to :subtype
	belongs_to :attorney

	validates :number, :presence => true
	validates :case_type, :presence => true
	validates :subtype, :presence => true
end
