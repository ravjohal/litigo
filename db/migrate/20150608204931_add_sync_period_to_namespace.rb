class AddSyncPeriodToNamespace < ActiveRecord::Migration
  def change
    add_column :namespaces, :sync_period, :integer
  end
end
