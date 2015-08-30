class AddReminderFlagToEvent < ActiveRecord::Migration
  def up
    add_column :events, :is_reminder, :boolean, :default => false
  end

  def down
    remove_column :events, :is_reminder
  end
end
