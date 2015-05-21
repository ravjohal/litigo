class AddRoleToCaseContact < ActiveRecord::Migration
  def change
    add_column :case_contacts, :role, :string
  end
end
