class AddIndexMedicalIdToInjuries < ActiveRecord::Migration
  def self.up
    add_index :injuries, :medical_id
  end

  def self.down
    remove_index :injuries, :medical_id
  end
end
