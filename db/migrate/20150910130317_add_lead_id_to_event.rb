class AddLeadIdToEvent < ActiveRecord::Migration
  def up
    add_column :events, :lead_id, :integer
    add_index :events, :lead_id
  end

  def down
    remove_index :events, :lead_id
    remove_column :events, :lead_id
  end
end
