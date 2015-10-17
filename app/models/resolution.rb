class Resolution < ActiveRecord::Base
	
	TYPES = ['Settlement', 'Verdict']

	belongs_to :case
	belongs_to :firm
	belongs_to :user

	def settlement?
		'Settlement' == resolution_type.to_s
	end

	def verdict?
		'Verdict' == resolution_type.to_s
	end

end
