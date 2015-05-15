class AddPhoneNumbersToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phone_number_1, :string
    add_column :contacts, :phone_number_2, :string
  end
end
