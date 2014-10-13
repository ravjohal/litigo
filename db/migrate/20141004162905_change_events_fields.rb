class ChangeEventsFields < ActiveRecord::Migration
  def change
    add_column :events, :google_id, :string
    add_column :events, :etag, :string
    add_column :events, :status, :string
    add_column :events, :htmlLink, :string
    add_column :events, :summary, :string
    add_column :events, :start, :datetime
    add_column :events, :end, :datetime
    add_column :events, :endTimeUnspecified, :boolean
    add_column :events, :transparency, :string
    add_column :events, :visibility, :string
    add_column :events, :iCalUID, :string
    add_column :events, :sequence, :integer

  end
end
