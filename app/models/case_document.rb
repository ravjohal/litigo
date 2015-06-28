class CaseDocument < ActiveRecord::Base
	belongs_to :case
	belongs_to :document

	amoeba do
    	enable
  	end
end
