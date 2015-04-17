class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :fax
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :website

      t.timestamps null: false
    end
  end
end
