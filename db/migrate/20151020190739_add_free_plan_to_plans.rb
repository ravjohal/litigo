class AddFreePlanToPlans < ActiveRecord::Migration
  def change
    Plan.create :name => "Free Plan", :price => "0", :price_description => 'per user / month'
  end
end
