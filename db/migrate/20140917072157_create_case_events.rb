class CreateCaseEvents < ActiveRecord::Migration
  def change
  	drop_table :cases_events

    create_table :case_events do |t|
      t.integer :case_id
      t.integer :event_id

      t.timestamps
    end
  end
end
