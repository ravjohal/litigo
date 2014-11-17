class AddCorporationToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :corporation, :boolean
  end
end
