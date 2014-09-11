class CreatePlaintiffs < ActiveRecord::Migration
  def change
    create_table :plaintiffs do |t|

      t.timestamps
    end
  end
end
