class AddDocketNumberToCase < ActiveRecord::Migration
  def change
    add_column :cases, :docket_number, :string
  end
end
