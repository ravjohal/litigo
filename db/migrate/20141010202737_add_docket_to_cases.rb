class AddDocketToCases < ActiveRecord::Migration
  def change
    add_column :cases, :docket, :string
  end
end
