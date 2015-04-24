class AddUserIdFirmIdCaseIdToMedicalBills < ActiveRecord::Migration
  def change
    add_column :medical_bills, :firm_id, :integer
    add_column :medical_bills, :case_id, :integer
    add_column :medical_bills, :user_id, :integer
  end
end
