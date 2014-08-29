class RemoveFirmIdFromCases < ActiveRecord::Migration
  def change
    remove_column :cases, :firm_id, :integer
  end
end
