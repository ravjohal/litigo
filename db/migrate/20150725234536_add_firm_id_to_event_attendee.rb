class AddFirmIdToEventAttendee < ActiveRecord::Migration
  def change
    add_column :event_attendees, :firm_id, :integer
  end
end
