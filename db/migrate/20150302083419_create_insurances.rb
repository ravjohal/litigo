class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :insurance_type
      t.string :insurance_provider
      t.decimal :policy_limit
      t.string :claim_number
      t.string :policy_holder
      t.integer :case_id
      t.integer :firm_id

      t.timestamps null: false
    end
  end
end
