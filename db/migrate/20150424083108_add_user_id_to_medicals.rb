class AddUserIdToMedicals < ActiveRecord::Migration
  def change
    add_column :medicals, :user_id, :integer
  end
end
