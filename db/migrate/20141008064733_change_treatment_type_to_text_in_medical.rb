class ChangeTreatmentTypeToTextInMedical < ActiveRecord::Migration
  def change
    change_column :medicals, :treatment_type, :text
  end
end
