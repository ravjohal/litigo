class Witness < ActiveRecord::Base
	has_one :contact, as: :contactable, dependent: :destroy
end
