class AddTenantToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :tenant, :string
  end
end
