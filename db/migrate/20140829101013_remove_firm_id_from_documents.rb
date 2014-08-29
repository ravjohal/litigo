class RemoveFirmIdFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :firm_id, :integer
  end
end
