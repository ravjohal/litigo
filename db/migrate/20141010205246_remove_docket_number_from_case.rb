class RemoveDocketNumberFromCase < ActiveRecord::Migration
  def change
    remove_column :cases, :DocketNumber, :string
  end
end
