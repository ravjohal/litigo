class AddIndexUserIdToCases < ActiveRecord::Migration
  def self.up
    add_index :cases, :user_id
  end

  def self.down
    remove_index :cases, :user_id
  end
end
