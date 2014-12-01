class AddDateOfBirthToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :date_of_birth, :datetime
  end
end
