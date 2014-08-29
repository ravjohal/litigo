class RemoveCreationDateFromCase < ActiveRecord::Migration
  def change
    remove_column :cases, :creation_date
  end
end
