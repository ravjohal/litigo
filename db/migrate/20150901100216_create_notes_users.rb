class CreateNotesUsers < ActiveRecord::Migration
  def change
    create_table :notes_users do |t|
      t.integer :note_id
      t.integer :user_id
      t.boolean :is_author

      t.timestamps null: false
    end
  end
end
