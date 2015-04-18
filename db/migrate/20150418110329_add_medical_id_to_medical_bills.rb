class AddMedicalIdToMedicalBills < ActiveRecord::Migration
  def change
    add_column :medical_bills, :company_id, :integer
    add_column :medical_bills, :medical_id, :integer
    add_column :medical_bills, :parent_id, :integer
  end
end
