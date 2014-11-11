Then(/^I create a case step by step$/) do
  click_on 'CASE MANAGEMENT'
  click_on 'CASES'
  step 'I create a case'
end

When(/^I create a case$/) do
  visit '/cases'
  click_on 'NEW CASE'
  sleep 0.5
  fill_in 'case_name', with: 'some case'
  click_on 'Create Case'
  expect(page).to have_content('Case was successfully created.')
end

Then(/^I verify required fields for case for user with email "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Case.where(id: u.id).last.name).to eq 'some case'
  expect(Case.where(id: u.id).last.case_number).to eq 1
end

Then(/^I change the case fields$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I verify required fields for case for user with email "(.*?)" are changed$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^all tabs are created$/) do
  click_on 'RESOLUTION'
  expect(page).to have_content('Resolution Amount:')
  click_on 'MEDICAL'
  expect(page).to have_content('Medical Overview')
  click_on 'INCIDENT'
  expect(page).to have_content('Incident date:')
  click_on 'DETAILS'
  expect(page).to have_content('Case Administration')
  click_on 'DOCUMENTS'
  expect(page).to have_content('NEW DOCUMENT')
  click_on 'NOTES'
  expect(page).to have_content('NEW NOTE')
  click_on 'CONTACTS'
  expect(page).to have_content('NEW CONTACT')
  click_on 'TASKS'
  expect(page).to have_content('NEW TASK')
end
