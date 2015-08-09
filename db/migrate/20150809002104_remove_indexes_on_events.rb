class RemoveIndexesOnEvents < ActiveRecord::Migration
  def change
  	# Events table
  	remove_index :events, :created_by
  	remove_index :events, :last_updated_by
  	remove_index :events, :event_series_id
  	remove_index :events, :namespace_id
  	remove_index :events, :calendar_id
  	remove_index :events, :nylas_namespace_id

  	add_index :events, :nylas_event_id
  end
end
