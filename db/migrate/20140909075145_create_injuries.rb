class CreateInjuries < ActiveRecord::Migration
  def change
    create_table :injuries do |t|
      t.string :injury_type
      t.string :region
      t.string :code
      t.boolean :dominant_side
      t.boolean :joint_fracture
      t.boolean :displaced_fracture
      t.boolean :disfigurement
      t.boolean :impairment
      t.boolean :permanence
      t.boolean :disabled
      t.decimal :disabled_percent
      t.boolean :surgery
      t.integer :surgery_count
      t.string  :surgery_type
      t.boolean :casted_fracture
      t.boolean :stitches
      t.boolean :future_surgery
      t.decimal :future_medicals
      t.integer :firm_id
      t.integer :medical_id

      t.timestamps
    end
  end
end
