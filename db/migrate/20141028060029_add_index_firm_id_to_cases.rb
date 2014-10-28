class AddIndexFirmIdToCases < ActiveRecord::Migration
  def self.up
    add_index :cases, :firm_id
  end

  def self.down
    remove_index :cases, :firm_id
  end
end
