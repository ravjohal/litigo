class ChangePriceDescriptionOfPlans < ActiveRecord::Migration
  def change
    plan = Plan.where(:id => 1).first
    plan.price_description = 'per user / month'
    plan.save!
    plan = Plan.where(:id => 2).first
    plan.price_description = ' per user / month'
    plan.save!
    plan = Plan.where(:id => 3).first
    plan.price_description = ' per user / year'
    plan.save!
    plan = Plan.where(:id => 4).first
    plan.price_description = 'per user / year'
    plan.save!
  end
end
