class AddIndexUserIdToDocuments < ActiveRecord::Migration
  def self.up
    add_index :documents, :user_id
  end

  def self.down
    remove_index :documents, :user_id
  end
end
