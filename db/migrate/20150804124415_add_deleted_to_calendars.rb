class AddDeletedToCalendars < ActiveRecord::Migration

  def up
    add_column :calendars, :deleted, :boolean, :default => false
    add_index :calendars, :deleted
  end

  def down
    remove_index :calendars, :deleted
    remove_column :calendars, :deleted
  end
end