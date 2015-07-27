class PopulateOwnerIdOnEvents < ActiveRecord::Migration
  def up
  	Event.all.each do |event|
  		event.owner = event.calendar ? event.calendar.user : event.user
  		event.save!
  	end
  end

  def down
  	Event.all.each do |event|
  		event.owner = nil
  	end
  end
end
