class CreateCaseContacts < ActiveRecord::Migration
  def change
    create_table :case_contacts do |t|
      t.integer :case_id
      t.integer :contact_id

      t.timestamps
    end
  end
end