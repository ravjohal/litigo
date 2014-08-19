class AddFirmIdToCases < ActiveRecord::Migration
  def change
    add_column :cases, :firm_id, :integer
  end
end
