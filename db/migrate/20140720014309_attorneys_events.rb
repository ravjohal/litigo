class AttorneysEvents < ActiveRecord::Migration
  def change
  	create_table :attorneys_events, id: false do |t|
      t.belongs_to :attorney
      t.belongs_to :event
    end
  end
end
