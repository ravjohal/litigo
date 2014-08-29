class ChangeNumberColumnInCase < ActiveRecord::Migration
  def change
    change_column :cases, :number, :string
  end
end
