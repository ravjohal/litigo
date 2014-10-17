class ChangeStatusToString < ActiveRecord::Migration
  def up
  	change_column :cases, :status, :string
  end
 
  def down
    change_column :cases, :status, 'integer USING CAST(status AS integer)'
  end
end
