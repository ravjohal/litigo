class ChangePoliceReportToBooleanInIncident < ActiveRecord::Migration
  def up
  	change_column :incidents, :police_report, 'boolean USING CAST(police_report AS boolean)'
  end
 
  def down
    	change_column :incidents, :police_report, :string
  end
end
