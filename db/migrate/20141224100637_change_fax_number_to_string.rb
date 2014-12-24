class ChangeFaxNumberToString < ActiveRecord::Migration
  def up
  	change_column :contacts, :fax_number, :string
  end
  def down
    change_column :contacts, :fax_number, 'integer USING CAST(fax_number AS integer)'
  end
end
