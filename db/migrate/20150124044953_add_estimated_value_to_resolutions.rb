class AddEstimatedValueToResolutions < ActiveRecord::Migration
  def change
    add_column :resolutions, :estimated_value, :integer
  end
end
