class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.integer :injury_id
      t.integer :firm_id
      t.boolean :surgery
      t.integer :surgery_count
      t.string :surgery_type
      t.boolean :casted_fracture
      t.boolean :stitches
      t.boolean :future_surgery
      t.decimal :future_medicals

      t.timestamps null: false
    end
  end
end
