class AddReferringContactIdToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :referring_contact_id, :integer
  end
end
