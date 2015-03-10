Then(/^I click on and create lead$/) do
  click_on 'CLIENT INTAKE'
  step 'I create a lead'
end

When(/^I create a lead$/) do
  visit '/client_intakes'
  click_on 'NEW CLIENT INTAKE'
  sleep 0.5
  fill_in 'lead_first_name', with: 'Leeds'
  fill_in 'lead_last_name', with: 'United'
  click_on 'Create Lead'
  expect(page).to have_content('Client intake was successfully created.')
end

Then(/^I verify lead has been created for user: "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Lead.where(id: u.id).last.lead_first_name).to eq 'Leeds'
end

Then(/^I edit lead$/) do
  click_on 'Edit'
  sleep 0.5
  fill_in 'lead_first_name', with: 'Leeds 2'
  fill_in 'lead_last_name', with: 'United 2'
  click_on 'Save'
end

Then(/^I verify lead has been changed for user: "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Lead.where(id: u.id).last.lead_first_name).to eq 'Leeds 2'
  expect(Case.where(id: u.id).last.lead_last_name).to eq 'United 2'
end

Then(/^I delete lead$/) do
  click_on 'Delete'
  click_on 'OK'
  expect(page).to have_content('Client intake was successfully destroyed.')
end
