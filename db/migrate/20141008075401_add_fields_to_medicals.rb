class AddFieldsToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :injury_summary, :text
    add_column :medicals, :medical_summary, :text
    add_column :medicals, :earnings_lost, :decimal
    add_column :medicals, :treatment_gap, :boolean
    add_column :medicals, :injections, :boolean
    add_column :medicals, :hospitalization, :boolean
    add_column :medicals, :hospital_stay_length, :integer
    add_column :medicals, :hospital_stay_length_unit, :string
  end
end
