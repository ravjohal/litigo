class AddFieldsToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :note_type, :string
    add_column :notes, :author, :string
  end
end
