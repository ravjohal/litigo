class AddTreatmentTypeToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :treatment_type, :string, array: true, default: []
  end
end
