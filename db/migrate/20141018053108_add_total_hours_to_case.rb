class AddTotalHoursToCase < ActiveRecord::Migration
  def change
    add_column :cases, :total_hours, :integer
  end
end
