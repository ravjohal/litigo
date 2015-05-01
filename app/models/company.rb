class Company < ActiveRecord::Base
	has_many :medical_bills
	has_many :contacts
	belongs_to :firm
	belongs_to :user

	accepts_nested_attributes_for :contacts, :reject_if => :all_blank

	def company_city_and_state
		if !self.city.empty? && !self.state.empty?
			self.city + ", " + self.state
		end
    end

    def company_city_or_state
    	if self.city.empty? && !self.state.empty?
    		self.state
    	elsif self.state.empty? && !self.city.empty?
    		self.city
    	else
    		self.company_city_and_state
    	end
    end
end
