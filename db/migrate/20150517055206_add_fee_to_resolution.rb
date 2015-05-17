class AddFeeToResolution < ActiveRecord::Migration
  def change
    add_column :resolutions, :contingent_fee, :decimal
  end
end
