class AddZipToFirm < ActiveRecord::Migration
  def change
    add_column :firms, :zip, :string
  end
end
