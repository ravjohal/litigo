class AddLastSyncToNamespace < ActiveRecord::Migration
  def change
    add_column :namespaces, :last_sync, :datetime
  end
end
