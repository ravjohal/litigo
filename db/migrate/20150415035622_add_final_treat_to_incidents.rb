class AddFinalTreatToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :final_treatment_date, :date
  end
end
