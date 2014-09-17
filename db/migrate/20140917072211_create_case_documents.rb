class CreateCaseDocuments < ActiveRecord::Migration
  def change
  	drop_table :cases_documents

    create_table :case_documents do |t|
      t.integer :case_id
      t.integer :document_id

      t.timestamps
    end
  end
end
