class CreateInterrogatories < ActiveRecord::Migration
  def change
    create_table :interrogatories do |t|
      t.text :question
      t.text :response
      t.string :requester
      t.string :responder
      t.integer :firm_id
      t.integer :case_id
      t.integer :created_by_id
      t.integer :last_updated_by_id
      t.integer :parent_id

      t.timestamps null: false
    end

    add_index :interrogatories, :firm_id
    add_index :interrogatories, :case_id
    add_index :interrogatories, :created_by_id
  end
end
