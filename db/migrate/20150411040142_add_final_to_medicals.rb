class AddFinalToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :final_treatment_date, :date
  end
end
