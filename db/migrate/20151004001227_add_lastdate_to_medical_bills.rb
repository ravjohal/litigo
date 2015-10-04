class AddLastdateToMedicalBills < ActiveRecord::Migration
  def change
    add_column :medical_bills, :last_date_of_service, :date
  end
end
