Then(/^I create a case step by step$/) do
  step 'I go to cases'
  step 'I create a case'
end

When /^I go to cases$/ do
  click_on 'Case Management'
  click_on 'CASES'
end

When(/^I create a case$/) do
  visit '/cases'
  click_on 'NEW CASE'
  sleep 0.5
  fill_in 'case_name', with: 'some case'
  select 'Domestic', :from => 'case_case_type'
  click_on 'Create Case'
  expect(page).to have_content('Case was successfully created.')
end

Then(/^I verify required fields for case for user with email "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Case.where(id: u.id).last.name).to eq 'some case'
  expect(Case.where(id: u.id).last.case_number).to eq 1
end

Then(/^I change the case fields$/) do
  click_on 'Edit'
  sleep 0.5
  fill_in 'case_name', with: 'some other case'
  fill_in 'case_docket_number', with: '11'
  click_on 'Save'
end

Then(/^I verify required fields for case for user with email "(.*?)" are changed$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Case.where(id: u.id).last.name).to eq 'some other case'
  expect(Case.where(id: u.id).last.docket_number).to eq '11'
  expect(Case.where(id: u.id).last.case_number).to eq 1
end

Then(/^all tabs are created$/) do
  click_on 'RESOLUTION'
  expect(page).to have_content('Resolution Amount:')
  # click_on 'MEDICAL'
  # expect(page).to have_content('Medical Overview')
  # click_on 'INCIDENT'
  # expect(page).to have_content('Incident date:')
  # click_on 'INSURANCE'
  # expect(page).to have_content('Insurance Summary')
  click_on 'DETAILS'
  expect(page).to have_content('Case Administration')
  click_on 'DOCUMENTS'
  expect(page).to have_content('NEW DOCUMENT')
  click_on 'NOTES'
  expect(page).to have_content('NEW NOTE')
  click_on 'CONTACTS'
  expect(page).to have_content('NEW CONTACT')
  click_on 'TASKS'
  expect(page).to have_content('My Tasks')
end

Given(/^Default case exist$/) do
  step 'Default case exist for user: "artem.suchov@gmail.com"'
end

Given(/^Default case exist for user: "(.*?)"$/) do |email|
  user = User.find_by :email => email
  firm = user.firm
  FactoryGirl.create(:case, user: user, firm: firm)
end

When(/^I go to first case$/) do
  step 'I click "CASES"'
  step 'I click to element with selector "#user_cases tr > td > a"'
end

When(/^I go to first firm case$/) do
  step 'I click "CASES"'
  step 'I click to element with selector "#cases tr > td > a"'
end

When(/^I select "(.*?)" from "(.*?)"$/) do |value, select_id|
  within "#s2id_#{select_id}" do
    first('.select2-choices').click
  end
  find('.select2-result-label', text: value).click
end

When(/^I select first item from "(.*?)"$/) do |select_id|
  within "#s2id_#{select_id}" do
    first('.select2-default').click
  end
  first('.select2-result-label').click
end

When(/^I clear select "(.*?)"$/) do |select_id|
  within "#s2id_#{select_id}" do
    first('.select2-search-choice-close').click
  end
end

Then(/^I verify assigned contact "(.*?)" for user "(.*?)"$/) do |contact_type, email|
  _case = Case.last
  expect(_case.case_contacts.joins(:contact).where(case_id: _case.id, firm_id: _case.firm_id, role: contact_type, :contacts => {:email => email}).size).to eq(1)
end