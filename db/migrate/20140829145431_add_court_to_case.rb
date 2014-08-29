class AddCourtToCase < ActiveRecord::Migration
  def change
    add_column :cases, :court, :string
  end
end
