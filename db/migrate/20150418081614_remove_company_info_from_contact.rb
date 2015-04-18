class RemoveCompanyInfoFromContact < ActiveRecord::Migration
  def change
    remove_column :contacts, :company
    remove_column :contacts, :company_address
    remove_column :contacts, :company_zipcode
    remove_column :contacts, :company_fax
    remove_column :contacts, :company_city
    remove_column :contacts, :company_state
    remove_column :contacts, :company_phone
  end
end
