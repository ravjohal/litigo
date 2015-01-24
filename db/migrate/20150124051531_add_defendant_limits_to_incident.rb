class AddDefendantLimitsToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :defendant_limits, :decimal
  end
end
