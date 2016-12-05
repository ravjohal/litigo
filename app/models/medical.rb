class Medical < ActiveRecord::Base
	
	DOCTOR_TYPE = %w(MD DO Specialist Other)
	TREATMENT_TYPE = %w(Ambulance ER Injections PT Chiro Meds Other)
	SCAN_TYPE = %w(Xray MRI CT EEG EKG Blood Other)

	belongs_to :case
	has_many :injuries, dependent: :destroy
	has_many :medical_bills, dependent: :destroy
	belongs_to :firm
	belongs_to :user
  before_save :set_tasks_due_dates


  accepts_nested_attributes_for :injuries, :allow_destroy => true
	accepts_nested_attributes_for :medical_bills, :reject_if => :all_blank, :allow_destroy => true

  def total_billed
		self.medical_bills.sum(:billed_amount) if self.medical_bills.present?
	end

  def total_adjustments
    self.medical_bills.sum(:adjustments) if self.medical_bills.present?
  end

	def total_paid
		self.medical_bills.sum(:paid_amount) if self.medical_bills.present?
	end

	def total_owed
		self.total_billed + self.total_adjustments + self.total_paid if self.medical_bills.present?
  end

  # TODO: Refactor to avoid doing a lot of DB calls
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
