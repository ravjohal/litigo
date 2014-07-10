class CreateDefendants < ActiveRecord::Migration
  def change
    create_table :defendants do |t|
      t.boolean :married
      t.boolean :employed
      t.text :job_description
      t.float :salary
      t.boolean :parent
      t.boolean :felony_convictions
      t.boolean :last_ten_years
      t.integer :jury_likeability

      t.timestamps
    end
  end
end
