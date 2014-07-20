class CasesTasks < ActiveRecord::Migration
  def change
  	create_table :cases_tasks, id: false do |t|
      t.belongs_to :case
      t.belongs_to :task
    end
  end
end
