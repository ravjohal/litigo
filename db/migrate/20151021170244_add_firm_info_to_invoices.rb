class AddFirmInfoToInvoices < ActiveRecord::Migration

  def up
    add_column :invoices, :firm_id, :integer
    add_column :invoices, :user_id, :integer

    add_index :invoices, :firm_id
    add_index :invoices, :user_id
  end

  def down
    remove_index :invoices, :firm_id
    remove_index :invoices, :user_id

    remove_column :invoices, :firm_id
    remove_column :invoices, :user_id
  end
end
