class AddCountyToCases < ActiveRecord::Migration
  def change
    add_column :cases, :county, :string
    remove_column :cases, :corporation
  end
end
