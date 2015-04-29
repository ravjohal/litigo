class AddLeadIdToCase < ActiveRecord::Migration
  def change
    add_column :cases, :lead_id, :integer
    remove_column :leads, :case_id
  end
end
