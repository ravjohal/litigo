class AddTypeToPayment < ActiveRecord::Migration

  def up
    add_column :payments, :sub_type, :string, :default => 'other'
  end

  def down
    remove_column :payments, :sub_type
  end
end
