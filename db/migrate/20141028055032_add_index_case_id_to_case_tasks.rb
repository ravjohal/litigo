class AddIndexCaseIdToCaseTasks < ActiveRecord::Migration
  def self.up
    add_index :case_tasks, :case_id
  end

  def self.down
    remove_index :case_tasks, :case_id
  end
end
