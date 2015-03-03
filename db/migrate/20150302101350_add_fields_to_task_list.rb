class AddFieldsToTaskList < ActiveRecord::Migration
  def change
    add_column :task_lists, :view_permission, :string
    add_column :task_lists, :amend_permission, :string
    add_column :task_lists, :task_import, :string
    add_column :task_lists, :user_id, :integer

    create_table :task_drafts do |t|
      t.integer :user_id
      t.integer :firm_id
      t.integer :task_list_id
      t.string :name
      t.integer :parent_id
      t.text :description
      t.integer :due_term
      t.string :conjunction
      t.string :anchor_date
      t.integer :number
    end
  end
end
