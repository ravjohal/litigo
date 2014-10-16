class AddUserAccountIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :user_account_id, :integer
  end
end
