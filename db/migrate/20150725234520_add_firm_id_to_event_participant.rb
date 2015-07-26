class AddFirmIdToEventParticipant < ActiveRecord::Migration
  def change
    add_column :event_participants, :firm_id, :integer
  end
end
