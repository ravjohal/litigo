class CreateGoogleCalendars < ActiveRecord::Migration
  def change
    create_table :google_calendars do |t|
      t.string :etag
      t.string :google_id
      t.string :summary
      t.string :description
      t.string :timeZone
      t.boolean :selected
      t.boolean :primary
      t.integer :user_id

      t.timestamps
    end
  end
end
