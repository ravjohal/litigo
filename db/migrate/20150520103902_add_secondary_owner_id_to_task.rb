class AddSecondaryOwnerIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :secondary_owner_id, :integer
  end
end
