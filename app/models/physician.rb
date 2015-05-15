class Physician < Contact
	has_many :medical_bills
	
	def set_type
		self.type = 'Physician'
	end
end
