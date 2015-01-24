class AddPlaintiffLimitsToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :plaintiff_limits, :decimal
  end
end
