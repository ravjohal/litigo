class AddSubtypeIdToCases < ActiveRecord::Migration
  def change
    add_column :cases, :subtype_id, :integer
  end
end
