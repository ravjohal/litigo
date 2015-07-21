When(/^I click on and create lead$/) do
  click_on 'Caller Intake'
  step 'I create a lead'
end

When(/^I create a lead$/) do
  click_on 'NEW CALLER INTAKE'
  sleep 0.5
  fill_in 'lead_first_name', with: 'Leeds'
  fill_in 'lead_last_name', with: 'United'
  click_on 'Create Lead'
  expect(page).to have_content('Client intake was successfully created.')
end

Then(/^I verify lead has been created for user: "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Lead.where(id: u.id).last.first_name).to eq 'Leeds'
end

When(/^I edit lead$/) do
  click_on 'CONTACT'
  click_on 'Edit'
  sleep 0.5
  fill_in 'lead_first_name', with: 'Leeds 2'
  fill_in 'lead_last_name', with: 'United 2'
  click_on 'Save'
end

Then(/^I verify lead has been changed for user: "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  lead = Lead.where(id: u.id).last
  expect(lead.first_name).to eq 'Leeds 2'
  expect(lead.last_name).to  eq 'United 2'
end

When(/^I delete lead$/) do
  find('#delete').click
  page.driver.browser.switch_to.alert.accept
  expect(page).to have_content('Client intake was successfully destroyed.')
end
