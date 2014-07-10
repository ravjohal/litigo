class CreateWitnesses < ActiveRecord::Migration
  def change
    create_table :witnesses do |t|
      t.string :witness_type
      t.string :witness_subtype
      t.string :witness_doctype

      t.timestamps
    end
  end
end
