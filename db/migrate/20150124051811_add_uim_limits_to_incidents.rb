class AddUimLimitsToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :uim_limits, :decimal
  end
end
