class RemoveDataFromMedicals < ActiveRecord::Migration
  def change
  	remove_column :medicals, :data, :hstore
  end
end
