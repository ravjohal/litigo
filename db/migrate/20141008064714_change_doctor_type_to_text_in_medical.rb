class ChangeDoctorTypeToTextInMedical < ActiveRecord::Migration
  def change
  	change_column :medicals, :doctor_type, :text
  end
end
