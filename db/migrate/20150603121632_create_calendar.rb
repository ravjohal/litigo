class CreateCalendar < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :description
      t.string :calendar_id
      t.string :name
      t.integer :namespace_id
      t.string :nylas_namespace_id
      t.boolean :active
    end
  end
end
