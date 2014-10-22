class AddDisplayNameToContact < ActiveRecord::Migration
  def change
    add_column :event_attendees, :contact_id, :integer
    remove_column :event_attendees, :email, :string
  end
end
