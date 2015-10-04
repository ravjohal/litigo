class AddSuffixToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :suffix, :string
  end
end
