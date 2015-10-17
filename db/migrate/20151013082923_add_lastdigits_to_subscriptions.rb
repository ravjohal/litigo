class AddLastdigitsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_digits, :string
  end
end
