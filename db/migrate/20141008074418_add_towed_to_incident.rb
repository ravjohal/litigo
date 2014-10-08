class AddTowedToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :towed, :boolean
  end
end
