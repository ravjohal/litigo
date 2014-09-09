class CreateInjuries < ActiveRecord::Migration
  def change
    create_table :injuries do |t|
      t.string :type
      t.string :region
      t.string :code

      t.timestamps
    end
  end
end
