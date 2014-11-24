class AddActiveToGoogleCalendar < ActiveRecord::Migration
  def change
    add_column :google_calendars, :active, :boolean, :default => false

    Event.all.each do |event|
      calendar = GoogleCalendar.find_by(google_id: event.google_calendar_id)
      calendar.update(active: true) if calendar.present?
    end
  end
end
