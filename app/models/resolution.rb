class Resolution < ActiveRecord::Base
	
	TYPES = ['Settlement', 'Verdict']

	belongs_to :case
	belongs_to :firm
end
