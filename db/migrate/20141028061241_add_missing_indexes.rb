class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :case_documents, :document_id
    add_index :case_events, :event_id
    add_index :case_tasks, :task_id
    add_index :contacts, :contact_user_id
    add_index :contacts, :case_id
    add_index :contacts, :event_id
    add_index :contacts, :firm_id
    add_index :contacts, :user_account_id
    add_index :documents, :firm_id
    add_index :events, :owner_id
    add_index :events, :firm_id
    add_index :events, :google_id
    add_index :events, :google_calendar_id
    add_index :google_calendars, :google_id
    add_index :google_calendars, :user_id
    add_index :google_calendars, :firm_id
    add_index :incidents, :firm_id
    add_index :injuries, :firm_id
    add_index :medicals, :firm_id
    add_index :notes, :case_id
    add_index :notes, :firm_id
    add_index :resolutions, :firm_id
    add_index :tasks, :firm_id
    add_index :user_events, :event_id
    add_index :users, :firm_id
  end

  def self.down
    remove_index :case_documents, :document_id
    remove_index :case_events, :event_id
    remove_index :case_tasks, :task_id
    remove_index :contacts, :contact_user_id
    remove_index :contacts, :case_id
    remove_index :contacts, :event_id
    remove_index :contacts, :firm_id
    remove_index :contacts, :user_account_id
    remove_index :documents, :firm_id
    remove_index :events, :owner_id
    remove_index :events, :firm_id
    remove_index :events, :google_id
    remove_index :events, :google_calendar_id
    remove_index :google_calendars, :google_id
    remove_index :google_calendars, :user_id
    remove_index :google_calendars, :firm_id
    remove_index :incidents, :firm_id
    remove_index :injuries, :firm_id
    remove_index :medicals, :firm_id
    remove_index :notes, :case_id
    remove_index :notes, :firm_id
    remove_index :resolutions, :firm_id
    remove_index :tasks, :firm_id
    remove_index :user_events, :event_id
    remove_index :users, :firm_id
  end
end
