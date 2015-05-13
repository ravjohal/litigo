class AddTimeBoundToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :time_bound, :string
  end
end
