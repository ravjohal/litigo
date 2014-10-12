class CreateMedicals < ActiveRecord::Migration
  def change
    create_table :medicals do |t|
      t.decimal :total_med_bills
      t.decimal :subrogated_amount
      t.boolean :injuries_within_three_days
      t.integer :length_of_treatment
      t.string :length_of_treatment_unit
      t.hstore :data
      t.text :injury_summary
      t.text :medical_summary
      t.decimal :earnings_lost
      t.boolean :treatment_gap
      t.boolean :injections
      t.boolean :hospitalization
      t.integer :hospital_stay_length
      t.string :hospital_stay_length_unit
      t.integer :firm_id
      t.integer :case_id

      t.timestamps
    end
  end
end
