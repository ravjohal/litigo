class AddFirmIdToTaskList < ActiveRecord::Migration
  def up
    add_column :task_lists, :firm_id, :integer
    remove_column :task_drafts, :user_id
    remove_column :task_drafts, :firm_id
  end

  def down
    remove_column :task_lists, :firm_id
    add_column :task_drafts, :user_id, :integer
    add_column :task_drafts, :firm_id, :integer
  end
end
