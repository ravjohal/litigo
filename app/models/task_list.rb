class TaskList < ActiveRecord::Base
	has_many :task_drafts, :dependent => :destroy
  belongs_to :user
  belongs_to :firm
  accepts_nested_attributes_for :task_drafts, :reject_if => :all_blank, :allow_destroy => true
  VIEW_PERMISSIONS = {all_firm: 'Everyone in the firm', author: 'Author Only'}
  AMEND_PERMISSIONS = {all_firm: 'Everyone in the firm', admins_attorneys: 'Admins and Attorneys Only', admins: 'Administrators Only', author: 'Author Only'}
  TASK_IMPORT = {automatic: 'Automatically import', manual: 'Manual import'}
  validates_presence_of :name
end
