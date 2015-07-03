class Note < ActiveRecord::Base
	belongs_to :case
	belongs_to :user
	belongs_to :firm
	attr_accessor :add_task, :task_name, :task_due_date, :task_sms_reminder, :task_email_reminder,
								:task_description, :task_estimated_time, :task_estimated_time_unit,
								:task_owner_id, :task_secondary_owner_id, :task_add_event, :task_google_calendar_id
end
