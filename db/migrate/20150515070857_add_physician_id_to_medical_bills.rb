class AddPhysicianIdToMedicalBills < ActiveRecord::Migration
  def change
    add_column :medical_bills, :physician_id, :integer
  end
end
