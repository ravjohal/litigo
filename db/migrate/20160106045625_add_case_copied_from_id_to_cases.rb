class AddCaseCopiedFromIdToCases < ActiveRecord::Migration
  def change
    add_column :cases, :case_copied_from_id, :integer
  end
end
