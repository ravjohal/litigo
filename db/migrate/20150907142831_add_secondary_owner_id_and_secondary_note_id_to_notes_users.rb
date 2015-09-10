class AddSecondaryOwnerIdAndSecondaryNoteIdToNotesUsers < ActiveRecord::Migration
  def change
    add_column :notes_users, :secondary_owner_id, :integer
    add_index  :notes_users, :secondary_owner_id
  end
end
