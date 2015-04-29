class Medical < ActiveRecord::Base
	
	DOCTOR_TYPE = ['MD', 'DO', 'Specialist', 'Other']
	TREATMENT_TYPE = ['PT', 'Chiro', 'Meds', 'Other']

	belongs_to :case
	has_many :injuries, dependent: :destroy
	has_many :medical_bills, dependent: :destroy
	belongs_to :firm
	belongs_to :user
  before_save :set_tasks_due_dates


  accepts_nested_attributes_for :injuries, :allow_destroy => true
	accepts_nested_attributes_for :medical_bills, :reject_if => :all_blank, :allow_destroy => true

	def total_billed
  		self.medical_bills.to_a.sum(&:billed_amount) if self.medical_bills
  	end

  	def total_paid
  		self.medical_bills.to_a.sum(&:paid_amount) if self.medical_bills
  	end

  	def total_owed
  		self.total_billed + self.total_paid if self.medical_bills
    end

  def set_tasks_due_dates
    attrs = TaskDraft::ANCHOR_DATE_HASH['medical'].keys & self.changed
    if attrs.present?
      attrs.each do |attr|
        self.case.tasks.where(anchor_date: "medical.#{attr}").each do |task|
          task.set_due_date!(self.try(attr))
        end
      end
    end
  end
end
