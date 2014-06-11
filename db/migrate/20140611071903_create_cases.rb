class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :name
      t.integer :number
      t.text :description
      t.decimal :medical_bills

      t.timestamps
    end
  end
end
