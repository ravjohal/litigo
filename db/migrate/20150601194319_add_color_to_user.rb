class AddColorToUser < ActiveRecord::Migration
  def change
    add_column :users, :events_color, :string
  end
end
