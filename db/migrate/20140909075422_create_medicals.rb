class CreateMedicals < ActiveRecord::Migration
  def change
    create_table :medicals do |t|
      t.decimal :total_med_bills
      t.decimal :subrogated_amount
      t.boolean :injuries_within_three_days
      t.integer :length_of_treatment
      t.string :length_of_treatment_unit
      t.string :doctor_type
      t.string :treatment_type

      t.timestamps
    end
  end
end
