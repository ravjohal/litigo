class ChangeDoctorTypeToTextInMedical < ActiveRecord::Migration
  def self.up
    change_column :medicals, :doctor_type, :text
  end
 
  def self.down
    change_column :medicals, :doctor_type, :string
  end
end
