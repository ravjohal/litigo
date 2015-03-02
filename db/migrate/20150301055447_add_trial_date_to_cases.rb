class AddTrialDateToCases < ActiveRecord::Migration
  def change
    add_column :cases, :trial_date, :date
  end
end
