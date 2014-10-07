class Resolution < ActiveRecord::Base
	belongs_to :case
	belongs_to :firm
end
