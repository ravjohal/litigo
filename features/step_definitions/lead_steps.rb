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
end

When(/^I fill lead case fields$/) do
  select 'Personal Injury', :from => 'lead_case_type'
  select 'Open Wound', :from => 'lead_primary_injury'
end

When(/^I check lead text field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  click_on 'Edit'
  sleep 0.5
  fill_in "lead_#{field}", with: text
  click_on 'Save'
  step "I verify lead field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check contact lead text field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  step 'I click on "CONTACT"'
  step "I check lead text field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check lead select field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  click_on 'Edit'
  sleep 0.5
  select text, :from => "lead_#{field}"
  click_on 'Save'
  step "I verify lead field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check contact lead select field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  step 'I click on "CONTACT"'
  step "I check lead select field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check lead select with option value "(.*?)" for field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |validate_value, field, text, user|
  click_on 'Edit'
  sleep 0.5
  select text, :from => "lead_#{field}"
  click_on 'Save'
  step "I verify lead field \"#{field}\" by \"#{validate_value}\" for user: \"#{user}\""
end

When(/^I check contact lead select with option value "(.*?)" for field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |validate_value, field, text, user|
  step 'I click on "CONTACT"'
  step "I check lead select with option value \"#{validate_value}\" for field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I verify lead field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  u = User.where(email: user).last
  lead = Lead.where(id: u.id).last
  expect(lead.attributes[field].to_s).to eq(text.to_s)
end

Then(/^I verify lead case was created for user: "(.*?)"$/) do |user|
  u = User.where(email: user).last
  lead = Lead.where(id: u.id).last
  expect(lead.case).to_not be_nil
end