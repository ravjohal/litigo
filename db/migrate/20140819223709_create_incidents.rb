class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.date :incident_date
      t.date :statute_of_limitations
      t.integer :defendant_liability
      t.boolean :alcohol_involved, default: false
      t.boolean :weather_factor, default: false
      t.decimal :property_damage, precision: 8, scale: 2
      t.boolean :airbag_deployed, default: false
      t.string :speed
      t.string :police_report
      t.references :case

      t.timestamps
    end
  end
end
