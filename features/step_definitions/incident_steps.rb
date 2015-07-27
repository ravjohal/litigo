# Then(/^I create the contact$/) do
#   visit '/contacts'
#   click_on 'NEW CONTACT'
#   find("option[value='Attorney']").click
#   fill_in 'contact_first_name', with: 'Artem'
#   fill_in 'contact_last_name', with: 'Such'
#   click_on 'Create Contact'
#   expect(page).to have_content('Contact was successfully created.')
# end
#
# Then(/^The contact for user with email "(.*?)" should be saved to the db$/) do |arg1|
#   u = User.where(email: arg1).first
#   expect(Contact.where(id: u.id).first.first_name).to eq 'Artem'
#   expect(Contact.where(id: u.id).first.last_name).to eq 'Suchov'
# end

Then(/^I create the incident$/) do
  click_on 'Case Management'
  click_on 'CASES'
  click_on 'some'
  click_on 'INCIDENT'
  sleep 0.5
  click_on 'Edit'
  find("option[value='GIECO']").click
  click_on 'Save'
  expect(page).to have_content 'incident was successfully updated.'
end

Then(/^The incident for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Incident.where(id: u.id).last.insurance_provider).to eq 'GIECO'
end