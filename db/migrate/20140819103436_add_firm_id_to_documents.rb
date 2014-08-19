class AddFirmIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :firm_id, :integer
  end
end
