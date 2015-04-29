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
      if self.conjunction.downcase == 'after'
        self.due_date = date + self.due_term.days
      elsif self.conjunction.downcase == 'before'
        self.due_date = date - self.due_term.days
      end
      self.save!
      if self.children.present?
        self.children.each do |child|
          child.set_due_date!(self.due_date)
        end
      end
    end
  end
end
