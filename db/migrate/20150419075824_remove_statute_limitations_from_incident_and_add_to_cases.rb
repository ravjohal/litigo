class RemoveStatuteLimitationsFromIncidentAndAddToCases < ActiveRecord::Migration
  def change
  	add_column :cases, :statute_of_limitations, :date

  	Incident.find_each do |incident|
  		if incident.case
       		incident.case.update_attribute(:statute_of_limitations, incident.statute_of_limitations)
       	end
     end

     remove_column :incidents, :statute_of_limitations
  end
end
