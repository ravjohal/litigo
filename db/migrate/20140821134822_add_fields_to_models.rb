class AddFieldsToModels < ActiveRecord::Migration
  def change
    add_column :cases, :doc_number, :string
    add_column :cases, :judge, :string
    add_column :cases, :court, :string
    add_column :cases, :corporation, :boolean
    add_column :cases, :status, :string
    add_column :cases, :creation_date, :datetime
    add_column :cases, :closing_date, :datetime
    add_column :plantiffs, :case_id, :integer
    add_column :defendants, :case_id, :integer
  end
end
