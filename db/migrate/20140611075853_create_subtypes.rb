class CreateSubtypes < ActiveRecord::Migration
  def change
    create_table :subtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
