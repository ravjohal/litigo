Given(/^I am logged in user$/) do
  step "I fill in the sign_up form with email \"#{email}\" password \"#{password}\""
  step "I should be logged in user"
end

When(/^I create a case$/) do
  visit '/cases'
  click_on 'NEW CASE'
  sleep 0.5
  fill_in 'case_name', with: 'some case'
  click_on 'Create Case'
  expect(page).to have_content('Case was successfully created.')
end

When(/^I create the resolution$/) do
  click_on 'RESOLUTION'
  sleep 0.5
  click_on 'Edit'
  fill_in 'resolution_settlement_demand', with: 1
  # binding.pry
  fill_in 'resolution_jury_demand', with: 3
  fill_in 'resolution_resolution_amount', with: 2
  find("option[value='SETTLEMENTS']").click
  click_on 'Update Resolution'
  expect(page).to have_content('resolution was successfully updated.')
end

Then(/^The resolution for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Resolution.where(id: u.id).first.resolution_type).to eq 'SETTLEMENTS'
  expect(Resolution.where(id: u.id).first.settlement_demand).to eq 1
  expect(Resolution.where(id: u.id).first.jury_demand).to eq 3
  expect(Resolution.where(id: u.id).first.resolution_amount).to eq 2
end