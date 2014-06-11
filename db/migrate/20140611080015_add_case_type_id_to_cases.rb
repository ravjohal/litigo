class AddCaseTypeIdToCases < ActiveRecord::Migration
  def change
    add_column :cases, :case_type_id, :integer
  end
end
