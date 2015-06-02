class SetUsersEventsColors < ActiveRecord::Migration
  def up
    User.reset_column_information
    Firm.all.each do |firm|
      firm.users.each_with_index do |user, index|
        user.update(events_color: user.color(index)) if user.events_color.blank?
      end
    end
  end

  def down
    Firm.all.each do |firm|
      firm.users.each do |user|
        user.update(events_color: nil)
      end
    end
  end
end
