class ChangeNumberToInteger < ActiveRecord::Migration
  def change
  	rename_column :cases, :number, :case_number
  	change_column :cases, :case_number, 'integer USING CAST(case_number AS integer)'
  end
end
