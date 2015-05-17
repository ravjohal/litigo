class AddMoreInfoToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :location, :string
    add_column :incidents, :police_report_number, :string
  end
end
