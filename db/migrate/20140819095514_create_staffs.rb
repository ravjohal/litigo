class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :staff_type

      t.timestamps
    end
  end
end
