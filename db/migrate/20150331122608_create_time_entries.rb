class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.integer :user_id
      t.date :date
      t.decimal :hours
      t.integer :case_id
      t.text :description
      t.string :charge_type
      t.decimal :hourly_rate
      t.decimal :contingent_fee
      t.decimal :fixed_fee
      t.string :aba_code

      t.timestamps null: false
    end
  end
end
