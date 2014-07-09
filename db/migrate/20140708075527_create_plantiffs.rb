class CreatePlantiffs < ActiveRecord::Migration
  def change
    create_table :plantiffs do |t|

      t.timestamps
    end
  end
end
