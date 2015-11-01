class AddRelationsToInvoice < ActiveRecord::Migration

  def up
    add_column :time_entries, :invoice_id, :integer
    add_index :time_entries, :invoice_id

    add_column :expenses, :invoice_id, :integer
    add_index :expenses, :invoice_id
  end

  def down
    remove_index :time_entries, :invoice_id
    remove_index :expenses, :invoice_id

    remove_column :time_entries, :invoice_id
    remove_column :expenses, :invoice_id
  end
end
