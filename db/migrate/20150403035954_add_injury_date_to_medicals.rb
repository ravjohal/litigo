class AddInjuryDateToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :injury_date, :date
  end
end
