class AddIndexUserIdToNotes < ActiveRecord::Migration
  def self.up
    add_index :notes, :user_id
  end

  def self.down
    remove_index :notes, :user_id
  end
end
