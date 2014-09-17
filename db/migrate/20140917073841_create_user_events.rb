class CreateUserEvents < ActiveRecord::Migration
  def change
  	drop_table :events_users

    create_table :user_events do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
