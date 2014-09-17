class AddEventIdToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :event_id, :integer
  end
end
