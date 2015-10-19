Given /^I have some plans$/ do
  Plan.create!(:id => 1, :name => "Basic Month-to-month", :price => "15", :price_description => 'per user / month')
  Plan.create!(:id => 4, :name => "Basic Annual", :price => "150", :price_description => 'per user / year')
end

When(/^I subscribe to subscription plan with email "(.*?)" with valid data$/) do |arg1|
  visit '/plans'
  click_on 'Sign up'
  fill_in 'subscription_email', with: arg1
  fill_in 'card_number', with: '4242424242424242'
  fill_in 'card_code', with: '123'
  select '1 - January', from: 'card_month'
  select '2016', from: 'card_year'
  click_on 'Subscribe'

end

When(/^I subscribe to subscription plan with email "(.*?)" with invalid card number$/) do |arg1|
  visit '/plans'
  click_on 'Sign up'
  fill_in 'subscription_email', with: arg1
  fill_in 'card_number', with: '12332'
  fill_in 'card_code', with: '123'
  select '1 - January', from: 'card_month'
  select '2016', from: 'card_year'
  click_on 'Subscribe'
end

When(/^I change subscription plan$/) do
  click_on 'Sign up'
  sleep 0.3
  step 'I confirm popup'
end

When(/^I cancel subscription plan$/) do
  click_on 'Cancel'
end

When(/^I update card info with email "(.*?)" with valid data$/) do |arg1|
  click_on 'Details'
  click_on 'Change Card'
  fill_in 'subscription_email', with: arg1
  fill_in 'card_number', with: '4242424242424242'
  fill_in 'card_code', with: '123'
  select '1 - January', from: 'card_month'
  select '2016', from: 'card_year'
  click_on 'Update'
end

Then(/^The subscription for user with email "(.*?)" should not be saved to the db$/) do |arg1|
  expect(page).to have_content('This card number looks invalid.')
end

Then(/^The subscription for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  subscription = Subscription.where(id: u.id).first
  expect(page).to have_content('Thank you for subscribing!')
  expect(page).to have_content('You have signed up')
  expect(subscription.last_digits).to eq '4242'
  expect(subscription.email).to eq arg1
  expect(subscription.user_id.to_i).to eq 1
end

Then(/^The subscription for user with email "(.*?)" should be updated to the db$/) do |arg1|
  u = User.where(email: arg1).first
  subscription = Subscription.where(id: u.id).first
  expect(page).to have_content('Saved. Your card information has been updated.')
  expect(subscription.last_digits).to eq '4242'
  expect(subscription.email).to eq arg1
  expect(subscription.user_id.to_i).to eq 1
end

Then(/^The subscription plan for user with email "(.*?)" should be changed$/) do |arg1|
  u = User.where(email: arg1).first
  subscription = Subscription.where(id: u.id).first
  expect(page).to have_content('You have signed up for the Basic Annual')
  expect(page).to have_content('Plan succesfuly changed!')
  expect(subscription.last_digits).to eq '4242'
  expect(subscription.plan_id).to eq 4
  expect(subscription.user_id.to_i).to eq 1
end

Then(/^The subscription plan for user with email "(.*?)" should be canceled$/) do |arg1|
  u = User.where(email: arg1).first
  subscription = Subscription.where(id: u.id).first
  expect(page).to have_content('Your subscription has been canceled')
  expect(page).to have_content('You have canceled from any plans')
  expect(subscription.last_digits).to eq '4242'
  expect(subscription.plan_id).to eq nil
  expect(subscription.user_id.to_i).to eq 1
end