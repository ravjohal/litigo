class Case < ActiveRecord::Base
	belongs_to :case_type
	belongs_to :subtype
	belongs_to :attorney
end
