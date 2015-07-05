class AddEditEventsPermitToUser < ActiveRecord::Migration
  def change
    add_column :users, :edit_events_permit, :boolean, :default => false
  end
end
