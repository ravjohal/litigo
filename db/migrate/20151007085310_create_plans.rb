class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.string :price_description
      t.timestamps null: false
    end
    Plan.create :name => "Basic Month-to-month", :price => "15", :price_description => 'USD/month'
    Plan.create :name => "Advanced M2M", :price => "35", :price_description => 'USD/month'
    Plan.create :name => "Advanced Annual", :price => "420", :price_description => 'USD/year'
    Plan.create :name => "Basic Annual", :price => "150", :price_description => 'USD/year'
  end
end
