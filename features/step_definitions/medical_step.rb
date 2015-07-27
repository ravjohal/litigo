Then(/^I create the medical$/) do
  click_on 'Case Management'
  click_on 'CASES'
  click_on 'some'
  click_on 'MEDICAL'
  sleep 0.5
  click_on 'Edit'
  fill_in 'medical_total_med_bills', with: 2
  fill_in 'medical_subrogated_amount', with: 3
  click_on 'Save'
  expect(page).to have_content('Medical was successfully updated.')
end

Then(/^The medical for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Medical.find_by_id(u.id).total_med_bills).to eq 2
  expect(Medical.find_by_id(u.id).subrogated_amount).to eq 3
end

Then(/^I create the injury$/) do
  click_on 'MEDICAL'
  click_on 'ADD INJURY'
  find("option[value='Strain/Sprain']").click
  find("option[value='Head']").click
  click_on 'Create Injury'
  expect(page).to have_content('Injury was successfully created.')
end

Then(/^The injury for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.find_by_email(arg1)
  m = Medical.find_by_id(u.id)
  expect(Injury.find_by_medical_id(m.id).region).to eq 'Head'
  expect(Injury.find_by_medical_id(m.id).injury_type).to eq 'Strain/Sprain'
end