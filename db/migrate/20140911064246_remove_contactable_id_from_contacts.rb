class RemoveContactableIdFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :contactable_id, :integer
  end
end
