class Treatment < ActiveRecord::Base
	belongs_to :injury
	belongs_to :firm
end
