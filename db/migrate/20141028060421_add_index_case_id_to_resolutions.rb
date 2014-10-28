class AddIndexCaseIdToResolutions < ActiveRecord::Migration
  def self.up
    add_index :resolutions, :case_id
  end

  def self.down
    remove_index :resolutions, :case_id
  end
end
