class AddPrefixToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :prefix, :string
  end
end
