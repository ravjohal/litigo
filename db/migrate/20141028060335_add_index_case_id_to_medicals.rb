class AddIndexCaseIdToMedicals < ActiveRecord::Migration
  def self.up
    add_index :medicals, :case_id
  end

  def self.down
    remove_index :medicals, :case_id
  end
end
