class AddContactUserIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :contact_user_id, :integer
  end
end
