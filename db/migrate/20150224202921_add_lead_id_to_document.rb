class AddLeadIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :lead_id, :integer
  end
end
