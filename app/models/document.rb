class Document < ActiveRecord::Base
	has_one :user
	has_many :cases
end
