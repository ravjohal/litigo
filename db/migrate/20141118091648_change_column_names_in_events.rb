class ChangeColumnNamesInEvents < ActiveRecord::Migration
  def change
  	rename_column :events, :htmlLink, :html_link
  	rename_column :events, :endTimeUnspecified, :end_time_unspecified
  	rename_column :injuries, :primary, :primary_injury
  end
end
