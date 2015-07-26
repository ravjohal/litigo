class AddFirmIdToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :firm_id, :integer
  end
end
