class Phone < ActiveRecord::Base
	belongs_to :contact
	belongs_to :firm
end
