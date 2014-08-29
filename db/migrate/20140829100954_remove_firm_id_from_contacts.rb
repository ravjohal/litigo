class RemoveFirmIdFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :firm_id, :integer
  end
end
