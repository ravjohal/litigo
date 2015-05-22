class AddContactIdToLead < ActiveRecord::Migration
  def change
    add_column :leads, :contact_id, :integer
  end
end
