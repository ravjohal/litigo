class AddDefaultValueTrueToShowOnboarding < ActiveRecord::Migration
  def up
    change_column :users, :show_onboarding, :boolean, :default => true
    User.all.each do |user|
      user.show_onboarding = true
      user.save
    end
  end
end
