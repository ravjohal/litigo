class AddCorporationToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :corporation, :string
  end
end
