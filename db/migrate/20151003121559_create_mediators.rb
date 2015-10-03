class CreateMediators < ActiveRecord::Migration
  def change
    create_table :mediators do |t|

      t.timestamps null: false
    end
  end
end
