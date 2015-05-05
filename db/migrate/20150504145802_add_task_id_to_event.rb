class AddTaskIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :task_id, :integer
  end
end
