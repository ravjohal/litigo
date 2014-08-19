class AddCaseIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :case_id, :integer
  end
end
