class MedicalBill < ActiveRecord::Base
	before_save :paid_amount_negative

	belongs_to :user
	belongs_to :firm
	belongs_to :medical
	belongs_to :company
	# has_many :children, class_name: "MedicalBill", foreign_key: "parent_id", :dependent => :destroy
 #  	belongs_to :parent, class_name: "MedicalBill"

	#accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => true

	def paid_amount_negative
		self.paid_amount = -(self.paid_amount.abs)
	end
end
