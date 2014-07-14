class AddGoogleEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_email, :string
  end
end
