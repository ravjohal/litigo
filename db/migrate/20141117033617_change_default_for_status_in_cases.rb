class ChangeDefaultForStatusInCases < ActiveRecord::Migration
	def up
	  change_column :cases, :status, :string, :default => 'open'
	end

	def down
	  change_column :cases, :status, :string, :default => nil
	end
end
