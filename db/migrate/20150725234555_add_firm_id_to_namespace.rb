class AddFirmIdToNamespace < ActiveRecord::Migration
  def change
    add_column :namespaces, :firm_id, :integer
  end
end
