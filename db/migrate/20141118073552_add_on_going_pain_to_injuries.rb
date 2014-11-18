class AddOnGoingPainToInjuries < ActiveRecord::Migration
  def change
    add_column :injuries, :ongoing_pain, :boolean
  end
end
