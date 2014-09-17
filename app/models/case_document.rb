class CaseDocument < ActiveRecord::Base
	belongs_to :case
	belongs_to :document
end
