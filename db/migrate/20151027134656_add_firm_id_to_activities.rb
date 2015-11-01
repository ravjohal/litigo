class AddFirmIdToActivities < ActiveRecord::Migration
  def up
    add_column :activities, :firm_id, :integer
    add_index :activities, :firm_id
  end

  def down
    remove_column :activities, :firm_id
    remove_index :activities, :firm_id
  end
end
