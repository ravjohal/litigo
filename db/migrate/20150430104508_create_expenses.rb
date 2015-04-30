class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.date :created_date
      t.string :expense
      t.string :aba_billing_code
      t.decimal :amount
      t.text :description
      t.integer :case_id
      t.integer :firm_id

      t.timestamps null: false
    end
  end
end
