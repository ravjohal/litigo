class AddDocketNumberToCase < ActiveRecord::Migration
  def change
    add_column :cases, :DocketNumber, :string
  end
end
