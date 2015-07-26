class DeleteUneededTables < ActiveRecord::Migration
  def up
  	drop_table :witnesses
  	drop_table :staffs
  	drop_table :plantiffs
  	drop_table :defendants
  	drop_table :clients
  	drop_table :treatments
  end

  def down

  end
end
