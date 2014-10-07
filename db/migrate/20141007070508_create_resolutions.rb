class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.integer :case_id
      t.integer :firm_id
      t.decimal :settlement_demand
      t.decimal :jury_demand
      t.decimal :resolution_amount
      t.string :resolution_type

      t.timestamps null: false
    end
  end
end
