class AddCaseToEventRelation < ActiveRecord::Migration
  def up
    add_column :events, :case_id, :integer
    add_index :events, :case_id
  end

  def down
    remove_index :events, :case_id
    remove_column :events, :case_id
  end
end