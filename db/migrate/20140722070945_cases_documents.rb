class CasesDocuments < ActiveRecord::Migration
  def change
  	create_table :cases_documents, id: false do |t|
      t.belongs_to :case
      t.belongs_to :document
    end
  end
end
