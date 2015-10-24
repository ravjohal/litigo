class ChangeInvoiceDefaults < ActiveRecord::Migration
  def change
    change_column :invoices, :amount, :decimal, :default => 0
    change_column :invoices, :balance, :decimal, :default => 0
    change_column :invoices, :payments, :decimal, :default => 0
  end
end
