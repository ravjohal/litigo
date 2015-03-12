class TaskDraft < ActiveRecord::Base
  has_many :children, class_name: "TaskDraft", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "TaskDraft"
	belongs_to :user
	belongs_to :firm
	belongs_to :task_list

  accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => true
  validates :due_term, :numericality => { :greater_than_or_equal_to => 0 }

  ANCHOR_DATE = ['case open', 'incident date', 'statute of limitations', 'trial date', 'previous task', 'close date']
  BEFORE_ANCHOR_DATE = ['statute of limitations', 'trial date', 'previous task', 'close date']

  def return_due_date(affair, parent=nil)
    due_date = nil
    if self.conjunction == 'after'
      case self.anchor_date
        when 'case open'
          due_date = affair.created_at + self.due_term.days
        when 'incident date'
          due_date = affair.incident.incident_date + self.due_term.days if affair.incident.incident_date.present?
        when 'statute of limitations'
          due_date = affair.incident.statute_of_limitations + self.due_term.days if affair.incident.incident_date.present?
        when 'trial date'
          due_date = affair.trial_date + self.due_term.days
        when 'previous task'
          due_date = parent.due_date + self.due_term.days
        when 'close date'
          due_date = affair.closing_date + self.due_term.days if affair.closing_date.present?
      end
    elsif self.conjunction == 'before'
      case self.anchor_date
        when 'trial date'
          due_date = affair.trial_date - self.due_term.days
        when 'statute of limitations'
          due_date = incident.statute_of_limitations - self.due_term.days if incident.incident_date.present?
        when 'close date'
          due_date = affair.closing_date - self.due_term.days if affair.closing_date.present?
        when 'previous task'
          due_date = parent.due_date - self.due_term.days
      end
    end
    return due_date
  end
end
