class AddStateToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :state, :string
  end
end
