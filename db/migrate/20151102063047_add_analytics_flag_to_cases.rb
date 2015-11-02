class AddAnalyticsFlagToCases < ActiveRecord::Migration

  def up
    add_column :cases, :analytics, :boolean, :default => false
    add_index :cases, :analytics

    User.where(email: %w(smalley.38@gmail.com smalley38@gmail.com)).find_each { |user| user.cases.update_all(analytics: true) }
  end

  def down
    remove_index :cases, :analytics
    remove_column :cases, :analytics
  end

end
