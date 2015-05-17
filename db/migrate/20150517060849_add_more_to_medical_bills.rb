class AddMoreToMedicalBills < ActiveRecord::Migration
  def change
    add_column :medical_bills, :adjustments, :decimal
    add_column :medical_bills, :account_number, :string
  end
end
