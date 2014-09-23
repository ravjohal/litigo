class RenameTypeToInjuryTypeOnInjury < ActiveRecord::Migration
  def change
  	rename_column :injuries, :type, :injury_type
  end
end
