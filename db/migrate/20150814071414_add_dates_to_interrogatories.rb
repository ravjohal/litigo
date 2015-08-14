class AddDatesToInterrogatories < ActiveRecord::Migration
  def change
    add_column :interrogatories, :req_date, :date
    add_column :interrogatories, :rep_date, :date
  end
end
