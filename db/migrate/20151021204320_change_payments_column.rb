class ChangePaymentsColumn < ActiveRecord::Migration
  def up
    rename_column :invoices, :payments, :payment_sum
  end

  def down
    rename_column :invoices, :payment_sum, :payments
  end
end
