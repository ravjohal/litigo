class AddNoteToResolution < ActiveRecord::Migration
  def change
    add_column :resolutions, :note, :text
  end
end
