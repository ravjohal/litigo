class ChangeTreatmentTypeToTextInMedical < ActiveRecord::Migration
  def self.up
    change_column :medicals, :treatment_type, :text
  end
 
  def self.down
    change_column :medicals, :treatment_type, :string
  end

end
