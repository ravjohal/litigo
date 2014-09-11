class CreateWitnesses < ActiveRecord::Migration
  def change
    create_table :witnesses do |t|

      t.timestamps
    end
  end
end
