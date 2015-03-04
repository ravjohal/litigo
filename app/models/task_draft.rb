class TaskDraft < ActiveRecord::Base
  has_many :children, class_name: "TaskDraft", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "TaskDraft"
	belongs_to :user
	belongs_to :firm
	belongs_to :task_list

  accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => true
  validates :due_term, :numericality => { :greater_than_or_equal_to => 0 }
end
