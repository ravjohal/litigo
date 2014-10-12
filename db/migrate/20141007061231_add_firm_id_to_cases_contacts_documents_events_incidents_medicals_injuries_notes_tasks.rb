class AddFirmIdToCasesContactsDocumentsEventsIncidentsMedicalsInjuriesNotesTasks < ActiveRecord::Migration
  def change
    add_column :cases, :firm_id, :integer
    add_column :contacts, :firm_id, :integer
    add_column :documents, :firm_id, :integer
    add_column :events, :firm_id, :integer
    add_column :incidents, :firm_id, :integer
    add_column :notes, :firm_id, :integer
    add_column :tasks, :firm_id, :integer
  end
end
