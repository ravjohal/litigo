Then(/^I create the medical$/) do
  click_on 'CASE MANAGEMENT'
  click_on 'CASES'
  click_on 'some'
  click_on 'MEDICAL'
  find("option[value='Soft Tissue Tear']").click
  find("option[value='Face']").click
  click_on 'Create Injury'
  expect(page).to have_content('Injury was successfully created.')
end

Then(/^The medical for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Medical.where(id: u.id).last).to eq 'Face'
end