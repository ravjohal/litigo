class AddAttorneyIdToCases < ActiveRecord::Migration
  def change
    add_column :cases, :attorney_id, :integer
  end
end
