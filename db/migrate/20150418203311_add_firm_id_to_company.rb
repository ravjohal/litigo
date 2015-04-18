class AddFirmIdToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :firm_id, :integer
  end
end
