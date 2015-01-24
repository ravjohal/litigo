class AddExpectedCloseToResolutions < ActiveRecord::Migration
  def change
    add_column :resolutions, :expected_close, :date
  end
end
