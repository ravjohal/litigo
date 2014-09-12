class AddCaseIdToMedical < ActiveRecord::Migration
  def change
    add_column :medicals, :case_id, :integer
  end
end
