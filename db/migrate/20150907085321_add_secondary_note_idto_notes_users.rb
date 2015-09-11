class AddSecondaryNoteIdtoNotesUsers < ActiveRecord::Migration
  def change
    add_column :notes_users,:secondary_note_id, :integer
    add_index  :notes_users,:secondary_note_id
  end
end
