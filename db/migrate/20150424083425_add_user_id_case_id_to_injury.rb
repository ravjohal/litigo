class AddUserIdCaseIdToInjury < ActiveRecord::Migration
  def change
    add_column :injuries, :user_id, :integer
    add_column :injuries, :case_id, :integer
  end
end
