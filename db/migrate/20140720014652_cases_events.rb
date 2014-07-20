class CasesEvents < ActiveRecord::Migration
  def change
  	create_table :cases_events, id: false do |t|
      t.belongs_to :case
      t.belongs_to :event
    end
  end
end
