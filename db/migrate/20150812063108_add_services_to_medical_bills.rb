class AddServicesToMedicalBills < ActiveRecord::Migration
  def change
    add_column :medical_bills, :services, :string
  end
end
