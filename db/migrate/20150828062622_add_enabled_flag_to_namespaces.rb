class AddEnabledFlagToNamespaces < ActiveRecord::Migration
  def up
    add_column :namespaces, :enabled, :boolean, :default => true
    add_index :namespaces, :enabled
  end

  def down
    remove_index :namespaces, :enabled
    remove_column :namespaces, :enabled
  end
end
