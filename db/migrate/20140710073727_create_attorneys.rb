class CreateAttorneys < ActiveRecord::Migration
  def change
    create_table :attorneys do |t|
      t.string :attorney_type
      t.string :firm

      t.timestamps
    end
  end
end
