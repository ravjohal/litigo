class ChangeTreatmentTypeToTextInMedical < ActiveRecord::Migration
  def self.up
    change_column :medicals, :treatment_type, :hstore
  end
 
  def self.down
    change_column :medicals, :treatment_type, :text
  end

end
