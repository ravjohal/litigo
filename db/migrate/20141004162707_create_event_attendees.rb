class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
      t.integer :event_id
      t.string :displayName
      t.string :email
      t.boolean :creator
      t.string :responseStatus

      t.timestamps
    end
  end
end
