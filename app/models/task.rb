class Task < ActiveRecord::Base
	has_many :case_tasks, :dependent => :destroy
	has_many :cases, :through => :case_tasks
	belongs_to :user
	belongs_to :firm
	belongs_to :owner, class_name: 'User'
	belongs_to :task_list
end
