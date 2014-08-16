class AddCaseIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :case_id, :integer
  end
end
