class TaskList < ActiveRecord::Base
	has_many :task_drafts
  accepts_nested_attributes_for :task_drafts, :reject_if => :all_blank, :allow_destroy => true
  VIEW_PERMISSIONS = {all_firm: 'Everyone in the firm', author: 'Author Only'}
  AMEND_PERMISSIONS = {all_firm: 'Everyone in the firm', author: 'Author Only', admins: 'Admins Only', admins_attorneys: 'Admins and Attorneys Only'}
  validates_presence_of :name
end
