class Task < ActiveRecord::Base
	has_many :case_tasks, :dependent => :destroy
	has_many :cases, :through => :case_tasks
  has_many :children, class_name: "Task", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Task"
  belongs_to :user
	belongs_to :firm
	belongs_to :owner, class_name: 'User'
  belongs_to :task_draft

  def set_due_date!(date)
    if date.present?
      operator = self.conjunction.downcase == 'after' ? '+' : '-'
      self.update(due_date: date.method(operator).(self.due_term.days))
      if self.children.present?
        self.children.each do |child|
          child.set_due_date!(self.due_date)
        end
      end
    end
  end
end
