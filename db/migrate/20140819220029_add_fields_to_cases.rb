class AddFieldsToCases < ActiveRecord::Migration
  def change
    add_column :cases, :corporation, :boolean, default: false
    add_column :cases, :status, :string
    add_column :cases, :creation_date, :date
    add_column :cases, :closing_date, :date
  end
end
