class CreateCaseTypes < ActiveRecord::Migration
  def change
    create_table :case_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
