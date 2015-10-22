class ChangeInvoiceNumberIndex < ActiveRecord::Migration

  def up
    remove_index :invoices, :number
    add_index :invoices, :number
  end

  def down
    remove_index :invoices, :number
    add_index :invoices, :number, :unique => true
  end

end
