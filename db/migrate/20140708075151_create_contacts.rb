class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :phone_number
      t.integer :fax_number
      t.string :email
      t.string :gender
      t.integer :age
      t.integer :contactable_id
      t.string :contactable_type

      t.timestamps
    end
  end
end
