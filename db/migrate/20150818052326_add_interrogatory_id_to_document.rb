class AddInterrogatoryIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :interrogatory_id, :integer

    add_index :documents, :interrogatory_id
  end
end
