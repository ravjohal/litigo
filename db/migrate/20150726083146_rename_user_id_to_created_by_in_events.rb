class RenameUserIdToCreatedByInEvents < ActiveRecord::Migration
  def up
  	rename_column :events, :user_id, :created_by
  end

  def down
  	rename_column :events, :created_by, :user_id
  end
end
