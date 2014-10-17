class ChangeNumberToInteger < ActiveRecord::Migration
  def up
    rename_column :cases, :number, :case_number
  	change_column :cases, :case_number, 'integer USING CAST(case_number AS integer)'
  end

  def down
    rename_column :cases, :case_number, :number
    change_column :cases, :number, :string
  end
end
