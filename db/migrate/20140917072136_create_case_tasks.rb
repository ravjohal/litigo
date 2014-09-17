class CreateCaseTasks < ActiveRecord::Migration
  def change
  	drop_table :cases_tasks

    create_table :case_tasks do |t|
      t.integer :case_id
      t.integer :task_id

      t.timestamps
    end
  end
end
