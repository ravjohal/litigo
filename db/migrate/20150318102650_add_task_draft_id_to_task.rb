class AddTaskDraftIdToTask < ActiveRecord::Migration
  def up
    add_column :tasks, :task_draft_id, :integer
  end

  def down
    remove_column :tasks, :task_draft_id
  end
end
