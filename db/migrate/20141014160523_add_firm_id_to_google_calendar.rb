class AddFirmIdToGoogleCalendar < ActiveRecord::Migration
  def change
    add_column :google_calendars, :firm_id, :integer
  end
end
