class AddAttachmentPoliceReportToIncidents < ActiveRecord::Migration
  def self.up
    change_table :incidents do |t|
      t.attachment :police_report
    end
  end

  def self.down
    remove_attachment :incidents, :police_report
  end
end
