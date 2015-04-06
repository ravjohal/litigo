class AddDatesToCases < ActiveRecord::Migration
  def change
    add_column :cases, :hearing_date, :date
    add_column :cases, :filed_suit_date, :date
  end
end
