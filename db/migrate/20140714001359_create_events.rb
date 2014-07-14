class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :subject
      t.string :location
      t.date :date
      t.time :time
      t.boolean :all_day
      t.boolean :reminder
      t.text :notes

      t.timestamps
    end
  end
end
