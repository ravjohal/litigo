class RemoveDocumentFromInterrogatory < ActiveRecord::Migration
  def change
    remove_column :interrogatories, :document, :string
  end
end
