class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :author
      t.string :type
      t.string :template

      t.timestamps
    end
  end
end
