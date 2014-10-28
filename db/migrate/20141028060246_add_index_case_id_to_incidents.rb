class AddIndexCaseIdToIncidents < ActiveRecord::Migration
  def self.up
    add_index :incidents, :case_id
  end

  def self.down
    remove_index :incidents, :case_id
  end
end
