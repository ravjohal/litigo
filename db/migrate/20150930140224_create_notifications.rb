class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :content
      t.references :notificable, polymorphic: true, index: true
      t.integer :user_id
      t.boolean :is_read, default: :false
      t.string  :author
      t.integer :note_id
      t.timestamps null: false
    end
  end
end
