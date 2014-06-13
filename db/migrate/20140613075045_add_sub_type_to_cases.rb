class AddSubTypeToCases < ActiveRecord::Migration
  def change
    add_column :cases, :subtype, :string
  end
end
