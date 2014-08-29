class AddStateToCase < ActiveRecord::Migration
  def change
    add_column :cases, :state, :string, limit: 2
  end
end
