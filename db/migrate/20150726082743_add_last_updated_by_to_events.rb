class AddLastUpdatedByToEvents < ActiveRecord::Migration
  def change
    add_column :events, :last_updated_by, :integer
  end
end
