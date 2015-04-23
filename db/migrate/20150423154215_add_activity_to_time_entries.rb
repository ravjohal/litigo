class AddActivityToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :activity, :string
  end
end
