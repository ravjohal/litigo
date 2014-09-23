class AddMedicalIdToInjury < ActiveRecord::Migration
  def change
    add_column :injuries, :medical_id, :integer
  end
end
