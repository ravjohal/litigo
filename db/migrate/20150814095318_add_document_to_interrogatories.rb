class AddDocumentToInterrogatories < ActiveRecord::Migration
  def change
    add_column :interrogatories, :document, :string
  end
end
