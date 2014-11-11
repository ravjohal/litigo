class AddPrimaryBooleanToInjuries < ActiveRecord::Migration
  class Injury < ActiveRecord::Base
  end

  def self.up
    add_column :injuries, :primary, :boolean, :default => false
    Injury.reset_column_information

    Medical.find_each do |med|
    	inj = med.injuries.first
    	inj.primary = true
    	inj.save!
    end
  end

  def self.down
  	remove_column :injuries, :primary, :boolean
  end
end
