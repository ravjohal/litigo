class AddDoctorTypeToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :doctor_type, :string, array: true, default: []
  end
end
