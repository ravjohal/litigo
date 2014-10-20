class SetDefaultTimeZone < ActiveRecord::Migration
  def change
    change_column :users, :time_zone, :string, :default => 'Pacific Time (US & Canada)'

    User.all.each do |user|
      user.time_zone = 'Pacific Time (US & Canada)'
      user.save!
    end
  end
end
