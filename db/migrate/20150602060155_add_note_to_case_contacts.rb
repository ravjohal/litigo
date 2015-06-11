class AddNoteToCaseContacts < ActiveRecord::Migration
  def change
    add_column :case_contacts, :note, :text
  end
end
