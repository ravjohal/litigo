class AddFaxesToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :fax_number_1, :string
    add_column :contacts, :fax_number_2, :string
  end
end
