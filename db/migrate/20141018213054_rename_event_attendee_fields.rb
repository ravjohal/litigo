class RenameEventAttendeeFields < ActiveRecord::Migration
  def change
    rename_column :event_attendees, :displayName, :display_name
    rename_column :event_attendees, :responseStatus, :response_status
  end
end
