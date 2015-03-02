class AddTopicToCases < ActiveRecord::Migration
  def change
    add_column :cases, :topic, :string
  end
end
