class Note < ActiveRecord::Base
	belongs_to :case

	has_many :users, through: :notes_user
	has_many :notes_user
	belongs_to :firm
	attr_accessor :add_task, :task_name, :task_due_date, :task_sms_reminder, :task_email_reminder,
								:task_description, :task_estimated_time, :task_estimated_time_unit,
								:task_owner_id, :task_secondary_owner_id, :task_add_event, :task_calendar_id
	accepts_nested_attributes_for :users,
																:reject_if => :all_blank,
																:allow_destroy => true
	accepts_nested_attributes_for :notes_user,
																:reject_if => :all_blank,
																:allow_destroy => true
end
