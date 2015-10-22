class CreatePayments < ActiveRecord::Migration
  def up
    create_table :payments do |t|
      t.references :user
      t.references :firm
      t.references :invoice
      t.decimal :amount, :default => 0
      t.date :date
      t.string :comment
      t.timestamps null: false
    end
  end

  def down
    drop_table :payments
  end
end
