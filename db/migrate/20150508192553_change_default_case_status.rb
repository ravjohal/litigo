class ChangeDefaultCaseStatus < ActiveRecord::Migration
  def change
    change_column :cases, :status, :string, :default => 'Active'
  end
end
