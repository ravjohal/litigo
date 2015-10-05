class AddIsRemoveToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :is_remove, :boolean, default: :false
  end
end
