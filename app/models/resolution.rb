class Resolution < ActiveRecord::Base
	
	TYPES = ['SETTLEMENTS', 'JURY VERDICTS']

	belongs_to :case
	belongs_to :firm
end
