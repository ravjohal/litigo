class AddFirmIdToPhone < ActiveRecord::Migration
  def change
    add_column :phones, :firm_id, :integer
  end
end
