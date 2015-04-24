class AddUserIdToResolution < ActiveRecord::Migration
  def change
    add_column :resolutions, :user_id, :integer
  end
end
