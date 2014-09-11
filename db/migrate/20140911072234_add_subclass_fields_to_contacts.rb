class AddSubclassFieldsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :married, :boolean
    add_column :contacts, :employed, :boolean
    add_column :contacts, :job_description, :text
    add_column :contacts, :salary, :decimal
    add_column :contacts, :parent, :boolean
    add_column :contacts, :felony_convictions, :boolean
    add_column :contacts, :last_ten_years, :boolean
    add_column :contacts, :jury_likeability, :integer
    add_column :contacts, :witness_type, :string
    add_column :contacts, :witness_subtype, :string
    add_column :contacts, :witness_doctype, :string
    add_column :contacts, :attorney_type, :string
    add_column :contacts, :staff_type, :string
  end
end
