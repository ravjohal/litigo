class AddFieldsToTask < ActiveRecord::Migration
  def up
    add_column :tasks, :conjunction, :string
    add_column :tasks, :due_term, :integer
    add_column :tasks, :anchor_date, :string
    add_column :tasks, :parent_id, :integer
  end

  def down
    remove_column :tasks, :conjunction
    remove_column :tasks, :due_term
    remove_column :tasks, :anchor_date
    remove_column :tasks, :parent_id
  end
end
