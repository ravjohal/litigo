class ChangePoliceReportToBooleanInIncident < ActiveRecord::Migration
  class << self
    include AlterColumn
  end
 
  def self.up
  	Incident.where(police_report: "").update_all(police_report: false)
    alter_column :incidents, :police_report, :boolean, "USING CAST(police_report AS boolean)", false
  end
 
  def self.down
  	change_column :incidents, :police_report, :string
    #raise ActiveRecord::IrreversibleMigration.new
  end
end
