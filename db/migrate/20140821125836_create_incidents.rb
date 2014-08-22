class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.belongs_to :case
      t.date :date_of_incident
      t.date :statute_of_limitations
      t.integer :liability
      t.boolean :alcohol
      t.boolean :weather_factor
      t.float :damage
      t.boolean :airbag
      t.float :speed

      t.timestamps
    end
  end
end
