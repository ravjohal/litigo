class AddNumberToPayment < ActiveRecord::Migration

  def up
    add_column :payments, :number, :integer, :default => 1
    add_index :payments, :number
  end

  def down
    remove_index :payments, :number
    remove_column :payments, :number
  end
end
