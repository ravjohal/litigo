class AddEventSeriesIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_series_id, :integer
    add_column :events, :all_day, :boolean
  end
end
