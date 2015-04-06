class AddDetailsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :minor, :boolean
    add_column :contacts, :major_date, :date
    add_column :contacts, :deceased, :boolean
    add_column :contacts, :date_of_death, :date
    add_column :contacts, :company_address, :string
    add_column :contacts, :company_zipcode, :string
    add_column :contacts, :company_city, :string
    add_column :contacts, :company_state, :string
    add_column :contacts, :website, :string
    add_column :contacts, :mobile, :string
  end
end
