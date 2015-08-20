class CreateSettlements < ActiveRecord::Migration
  def change
    create_table :settlements do |t|
      t.integer :firm_id
      t.integer :case_id
      t.integer :created_by_id
      t.integer :last_updated_by_id
      t.integer :template_id, default: 0
      t.timestamps null: false
    end

    add_index :settlements, :firm_id
    add_index :settlements, :case_id
    add_index :settlements, :template_id
    add_index :settlements, :created_by_id
  end
end
