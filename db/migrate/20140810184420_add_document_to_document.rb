class AddDocumentToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :document, :string
  end
end
