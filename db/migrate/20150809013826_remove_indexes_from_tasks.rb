class RemoveIndexesFromTasks < ActiveRecord::Migration
  def change
  	remove_index :tasks, :user_id
  	remove_index :tasks, :task_draft_id
  end
end
