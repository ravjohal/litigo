class AddFirmIdToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :firm_id, :integer
  end
end
