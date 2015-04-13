class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.integer :user_id
      t.string :file
      t.integer :firm_id
      t.text :description
      t.text :html_content
      t.string :name

      t.timestamps null: false
    end
  end
end
