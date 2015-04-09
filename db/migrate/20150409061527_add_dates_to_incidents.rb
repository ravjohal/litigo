class AddDatesToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :injury_date, :date
    add_column :incidents, :notice, :boolean
    add_column :incidents, :discovery_date, :date
    add_column :incidents, :first_sold_date, :date
    add_column :incidents, :foreign_object, :boolean
  end
end
