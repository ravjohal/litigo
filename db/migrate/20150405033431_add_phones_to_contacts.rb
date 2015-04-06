class AddPhonesToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :company_phone, :string
    add_column :contacts, :company_fax, :string
  end
end
