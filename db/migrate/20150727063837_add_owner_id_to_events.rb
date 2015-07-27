class AddOwnerIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :owner_id, :integer
    add_index :events, :owner_id
  end
end
