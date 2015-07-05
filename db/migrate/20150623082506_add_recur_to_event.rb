class AddRecurToEvent < ActiveRecord::Migration
  def up
    add_column :events, :recur, :boolean, :default => false
  end

  def down
    remove_column :events, :recur
  end
end
