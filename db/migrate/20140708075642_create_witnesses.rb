class CreateWitnesses < ActiveRecord::Migration
  def change
    create_table :witnesses do |t|
      t.string :witness_type
      t.string :witness_subtype
      t.string :witness_doctor_type

      t.timestamps
    end
  end
end
