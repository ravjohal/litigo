class AddParentIdToInsurance < ActiveRecord::Migration
  def change
    add_column :insurances, :parent_id, :integer
  end
end
