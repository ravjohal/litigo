class AddExtToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :ext, :string
  end
end
