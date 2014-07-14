json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :due_date, :completed, :sms_reminder, :email_reminder, :description
  json.url task_url(task, format: :json)
end
