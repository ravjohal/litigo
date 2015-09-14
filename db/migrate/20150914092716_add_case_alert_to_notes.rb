class AddCaseAlertToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :case_alert, :boolean
  end
end
