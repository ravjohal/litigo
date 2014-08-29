class ChangeStatusColumnTypeInCase < ActiveRecord::Migration
  def change
    remove_column :cases, :status, :string
    add_column :cases, :status, :integer, default: 0
  end
end
