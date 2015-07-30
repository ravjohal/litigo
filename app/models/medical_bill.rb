class MedicalBill < ActiveRecord::Base
	before_save :paid_adjustment_amount_negative, :save_firm_case_user

	belongs_to :user
	belongs_to :firm
	belongs_to :case
	belongs_to :medical
	belongs_to :company
	belongs_to :physician
	# has_many :children, class_name: "MedicalBill", foreign_key: "parent_id", :dependent => :destroy
 #  	belongs_to :parent, class_name: "MedicalBill"

	#accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => true

	def paid_adjustment_amount_negative
		self.paid_amount = -(self.paid_amount.abs) if self.paid_amount
		self.adjustments = -(self.adjustments.abs) if self.adjustments
	end

  	def total_billed_adjustment_paid_amounts
  		self.billed_amount.to_i + self.paid_amount.to_i + self.adjustments.to_i
  	end

  	def save_firm_case_user
  		self.firm = self.medical.firm
  		self.case = self.medical.case
  		self.user = self.medical.user
  	end
end
