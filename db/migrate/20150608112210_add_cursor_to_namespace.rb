class AddCursorToNamespace < ActiveRecord::Migration
  def change
    add_column :namespaces, :cursor, :string
  end
end
