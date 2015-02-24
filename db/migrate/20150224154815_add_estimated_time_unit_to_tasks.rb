class AddEstimatedTimeUnitToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :estimated_time_unit, :string
  end
end
