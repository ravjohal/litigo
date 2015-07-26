class DeleteUneededTables < ActiveRecord::Migration
  def change
  	drop_table :witnesses
  	drop_table :staffs
  	drop_table :plantiffs
  	drop_table :defendants
  	drop_table :clients
  end
end
