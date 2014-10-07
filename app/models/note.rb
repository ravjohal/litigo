class Note < ActiveRecord::Base
	belongs_to :case
	belongs_to :user
	belongs_to :firm
end
