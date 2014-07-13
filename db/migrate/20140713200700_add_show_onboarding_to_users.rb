class AddShowOnboardingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_onboarding, :boolean
  end
end
