class CreateTemplateDocuments < ActiveRecord::Migration
  def change
    create_table :template_documents do |t|
      t.text :html_content
      t.string :name
      t.integer :template_id
      t.integer :firm_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
