class AddTransferDateToCases < ActiveRecord::Migration
  def change
    add_column :cases, :transfer_date, :date
  end
end
