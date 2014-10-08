class AddFieldsToInjury < ActiveRecord::Migration
  def change
    add_column :injuries, :dominant_side, :boolean
    add_column :injuries, :joint_fracture, :boolean
    add_column :injuries, :displaced_fracture, :boolean
    add_column :injuries, :disfigurement, :boolean
    add_column :injuries, :impairment, :boolean
    add_column :injuries, :permanence, :boolean
    add_column :injuries, :disabled, :boolean
    add_column :injuries, :disabled_percent, :decimal
    add_column :injuries, :surgery, :boolean
    add_column :injuries, :surgery_count, :integer
    add_column :injuries, :surgery_type, :string
    add_column :injuries, :casted_fracture, :boolean
    add_column :injuries, :stitches, :boolean
    add_column :injuries, :future_surgery, :boolean
    add_column :injuries, :future_medicals, :decimal
  end
end
