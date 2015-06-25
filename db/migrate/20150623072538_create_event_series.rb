class CreateEventSeries < ActiveRecord::Migration
  def change
    create_table :event_series do |t|
      t.integer :frequency, :default => 1
      t.string :period, :default => 'monthly'
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :recur_start_date
      t.datetime :recur_end_date
      t.string :when_type
      t.boolean :all_day, :default => false
      t.integer :user_id
      t.integer :firm_id

      t.timestamps
    end
  end
end
