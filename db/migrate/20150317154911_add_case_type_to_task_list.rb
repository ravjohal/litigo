class AddCaseTypeToTaskList < ActiveRecord::Migration
  def up
    add_column :task_lists, :case_type, :string
    add_column :task_lists, :case_creator, :string
  end

  def down
    remove_column :task_lists, :case_type
    remove_column :task_lists, :case_creator
  end
end
