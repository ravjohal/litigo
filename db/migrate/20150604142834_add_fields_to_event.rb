class AddFieldsToEvent < ActiveRecord::Migration
  def up
    rename_table :events, :old_events
    create_table :events do |t|
      t.string :nylas_event_id
      t.string :nylas_calendar_id
      t.string :nylas_namespace_id
      t.text :description
      t.string :location
      t.boolean :read_only
      t.string :title
      t.boolean :busy
      t.string :status
      t.integer :namespace_id
      t.integer :calendar_id
      t.integer :user_id
      t.integer :task_id
      t.integer :firm_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :when_type
    end

    create_table :participants do |p|
      p.string :email
      p.string :name
    end

    create_table :event_participants do |p|
      p.string :status
      p.integer :event_id
      p.integer :participant_id
    end

    Event.reset_column_information
    OldEvent.reset_column_information
    OldEvent.where(google_id: nil).each do |oe|
      event = Event.create(description: oe.summary, location: oe.location, title: oe.subject, busy: true,
                           user_id: oe.owner_id, task_id: oe.task_id, firm_id: oe.firm_id, starts_at: oe.start, ends_at: oe.end)
    end
  end

  def down
    rename_table :events, :new_events
    rename_table :old_events, :events

    drop_table :participants
    drop_table :event_participants
  end
end
