When(/^I click on "(.*?)"$/) do |button|
  click_on button
end

When(/^I create a lead$/) do
  step 'I create a lead with name "Leeds" and last name "United"'
end

When(/^I create a lead with name "(.*?)" and last name "(.*?)"$/) do |first_name, last_name|
  click_on 'NEW CALLER INTAKE'
  sleep 0.5
  fill_in 'lead_first_name', with: first_name
  fill_in 'lead_last_name', with: last_name
  click_on 'Create Lead'
end

Then(/^I check message "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I verify lead has been created for user: "(.*?)"$/) do |arg1|
  step "I verify lead first name \"Leeds\" and last name \"United\" for user: \"#{arg1}\""
end

Then(/^I verify lead first name "(.*?)" and last name "(.*?)" for user: "(.*?)"$/) do |first_name, last_name, user|
  u = User.where(email: user).last
  lead = Lead.where(id: u.id).last
  expect(lead.first_name).to eq first_name
  expect(lead.last_name).to eq last_name
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
