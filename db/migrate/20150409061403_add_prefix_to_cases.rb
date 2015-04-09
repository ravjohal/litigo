class AddPrefixToCases < ActiveRecord::Migration
  def change
    add_column :cases, :prefix, :string
  end
end
