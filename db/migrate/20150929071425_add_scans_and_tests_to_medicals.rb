class AddScansAndTestsToMedicals < ActiveRecord::Migration

  def up
    add_column :medicals, :scans_tests, :string, array: true, default: []
  end

  def down
    remove_column :medicals, :scans_tests
  end
end
