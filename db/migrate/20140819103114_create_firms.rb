class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :fax
      t.string :tenant

      t.timestamps
    end
  end
end
