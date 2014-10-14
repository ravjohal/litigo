class RemoveNumberFromCases < ActiveRecord::Migration
  def change
    remove_column :cases, :number, :string
  end
end
