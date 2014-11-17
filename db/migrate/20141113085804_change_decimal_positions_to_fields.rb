class ChangeDecimalPositionsToFields < ActiveRecord::Migration
  def up
  	change_column :medicals, :total_med_bills, :decimal, :precision => 10, :scale => 2
  	change_column :medicals, :subrogated_amount, :decimal, :precision => 10, :scale => 2
  	change_column :medicals, :earnings_lost, :decimal, :precision => 10, :scale => 2
  	change_column :incidents, :property_damage, :decimal, :precision => 10, :scale => 2
  	change_column :cases, :medical_bills, :decimal, :precision => 10, :scale => 2
  	change_column :resolutions, :settlement_demand, :decimal, :precision => 10, :scale => 2
  	change_column :resolutions, :jury_demand, :decimal, :precision => 10, :scale => 2
  	change_column :resolutions, :resolution_amount, :decimal, :precision => 10, :scale => 2
  	change_column :injuries, :disabled_percent, :decimal, :precision => 5, :scale => 2
  	change_column :injuries, :future_medicals, :decimal, :precision => 10, :scale => 2
  end
  def down
    change_column :medicals, :total_med_bills, :decimal, :precision => 10, :scale => 2
    change_column :medicals, :subrogated_amount, :decimal, :precision => 10, :scale => 2
    change_column :medicals, :earnings_lost, :decimal, :precision => 10, :scale => 2
    change_column :incidents, :property_damage, :decimal, :precision => 10, :scale => 2
    change_column :cases, :medical_bills, :decimal, :precision => 10, :scale => 2
    change_column :resolutions, :settlement_demand, :decimal, :precision => 10, :scale => 2
    change_column :resolutions, :jury_demand, :decimal, :precision => 10, :scale => 2
    change_column :resolutions, :resolution_amount, :decimal, :precision => 10, :scale => 2
    change_column :injuries, :disabled_percent, :decimal, :precision => 5, :scale => 2
    change_column :injuries, :future_medicals, :decimal, :precision => 10, :scale => 2
  end
end
