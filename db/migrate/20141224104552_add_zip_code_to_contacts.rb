class AddZipCodeToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :zip_code, :string
  end
end
