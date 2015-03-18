class TaskList < ActiveRecord::Base
	has_many :task_drafts, :dependent => :destroy
  belongs_to :user
  belongs_to :firm
  accepts_nested_attributes_for :task_drafts, :reject_if => :all_blank, :allow_destroy => true
  VIEW_PERMISSIONS = {all_firm: 'Everyone in the firm', author: 'Author Only'}
  AMEND_PERMISSIONS = {all_firm: 'Everyone in the firm', admins_attorneys: 'Admins and Attorneys Only', admins: 'Administrators Only', author: 'Author Only'}
  TASK_IMPORT = {automatic: 'Automatically import', manual: 'Manual import'}
  validates_presence_of :name
  validates_presence_of :case_type, :if => lambda {self.task_import == 'automatic'}
  validates_presence_of :case_creator, :if => lambda {self.task_import == 'automatic'}

  def import_to_case!(case_id, user_id)
    affair = Case.find(case_id)
    self.task_drafts.each do |task_draft|
      parent_task = affair.tasks.find_or_initialize_by(task_draft_id: task_draft.id)
      task_attrs = {
          name: task_draft.name,
          description: task_draft.description,
          firm_id: affair.firm_id,
          user_id: user_id,
          conjunction: task_draft.conjunction,
          due_term: task_draft.due_term,
          anchor_date: task_draft.anchor_date,
          due_date: task_draft.return_due_date(affair),
          task_draft_id: task_draft.id
      }
      parent_task.update(task_attrs)
      CaseTask.find_or_create_by(case_id: affair.id, task_id: parent_task.id)
      if task_draft.children.present?
        task_draft.children.each do |child|
          child_task = affair.tasks.find_or_initialize_by(task_draft_id: child.id)
          child_attrs = {
              name: child.name,
              description: child.description,
              firm_id: affair.firm_id,
              user_id: user_id,
              conjunction: child.conjunction,
              due_term: child.due_term,
              anchor_date: child.anchor_date,
              parent_id: parent_task.id,
              due_date: child.return_due_date(affair, parent_task),
              task_draft_id: child.id
          }
          child_task.update(child_attrs)
          CaseTask.find_or_create_by(case_id: affair.id, task_id: child_task.id)
        end
      end
    end
  end
end
