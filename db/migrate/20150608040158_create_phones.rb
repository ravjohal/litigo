class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :label
      t.string :number
      t.integer :contact_id

      t.timestamps null: false
    end
  end
end
