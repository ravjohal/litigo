class RemovePrefixFromCases < ActiveRecord::Migration
  def change
    remove_column :cases, :prefix, :string
  end
end
