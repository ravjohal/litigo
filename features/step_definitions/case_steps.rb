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