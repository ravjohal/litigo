class AddSolSetManuallyToCase < ActiveRecord::Migration
  def change
    add_column :cases, :sol_priority, :integer
  end
end
