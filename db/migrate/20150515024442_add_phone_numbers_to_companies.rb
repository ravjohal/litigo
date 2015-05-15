class AddPhoneNumbersToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :fax_1, :string
    add_column :companies, :fax_2, :string
    add_column :companies, :phone_2, :string
    add_column :companies, :phone_1, :string
  end
end
