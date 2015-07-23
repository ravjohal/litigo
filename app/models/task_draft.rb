class TaskDraft < ActiveRecord::Base
  has_many :children, class_name: "TaskDraft", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "TaskDraft"
	belongs_to :user
	belongs_to :firm
	belongs_to :task_list
  has_many :tasks

  accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => true
  validates :due_term, :numericality => { :greater_than_or_equal_to => 0 }


  ANCHOR_DATE_HASH = {
      'affair' => {
          'created_at' => 'Case Open Date',
          'statute_of_limitations' => 'Statute of Limitations',
          'trial_date' => 'Trial Date',
          'closing_date' => 'Case Close Date',
          'hearing_date' => 'Hearing Date',
          'transfer_date' => 'Transfer Date'},
      'lead' => {
          'created_at' => 'Intake Date'
      },
      'incident' => {
          'incident_date' => 'Incident Date'
      },
      'medical' => {
          'final_treatment_date' => 'Final Treatment Date'
      }
  }

  def get_anchor_date
    ad = anchor_date.split('.')
    ad.count > 1 ? ANCHOR_DATE_HASH[ad[0]][ad[1]] : anchor_date
  end


  def return_due_date(affair, parent=nil)
    due_date = nil

    self.anchor_date ||= 'parent'
    self.conjunction ||= 'After'

    ad = anchor_date.split('.')
    operator = self.conjunction.downcase == 'after' ? '+' : '-'
    if ad.count > 1
      if ad[0] == 'affair'
        due_date = affair.try(ad[1]).try('to_date').method(operator).(self.due_term.days) if affair.try(ad[1]).present?
      else
        due_date = affair.try(ad[0]).try(ad[1]).try('to_date').method(operator).(self.due_term.days) if affair.try(ad[0]).try(ad[1]).present?
      end
    else
      due_date = parent.due_date.method(operator).(self.due_term.days) if parent && parent.due_date
    end
    return due_date
  end
end
