class AddRequesterIdAndResponderIdToInterrogatories < ActiveRecord::Migration
  def change
    add_column :interrogatories, :requester_id, :integer
    add_column :interrogatories, :responder_id, :integer

    remove_column :interrogatories, :requester
    remove_column :interrogatories, :responder
  end
end
