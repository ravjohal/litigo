
class ChangePoliceReportToBooleanInIncident < ActiveRecord::Migration
  class << self
    include AlterColumn
  end
 
  def self.up
    alter_column :incidents, :police_report, :boolean, "USING CAST(police_report AS boolean)", false
  end
 
  def self.down
  	change_column :incidents, :police_report, :string
    #raise ActiveRecord::IrreversibleMigration.new
  end
end
