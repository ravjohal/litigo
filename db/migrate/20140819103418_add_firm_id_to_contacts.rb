class AddFirmIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :firm_id, :integer
  end
end
