class AddAdjustorToInsurace < ActiveRecord::Migration

  def up
    add_column :insurances, :adjustor_id, :integer
    add_index :insurances, :adjustor_id
  end

  def down
    remove_index :insurances, :adjustor_id
    remove_column :insurances, :adjustor_id
  end
end
