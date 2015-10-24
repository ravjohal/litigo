class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :case
      t.references :contact
      t.date :due_date
      t.integer :number, :auto_increment => true
      t.decimal :amount
      t.decimal :balance
      t.decimal :payments
      t.string :status
      t.timestamps null: false
    end

    add_index :invoices, :number, :unique => true
  end
end
