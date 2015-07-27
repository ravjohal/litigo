Then(/^I create the contact$/) do
  visit '/contacts'
  click_on 'NEW CONTACT'
  find("option[value='Attorney']").click
  fill_in 'contact_first_name', with: 'Artem'
  fill_in 'contact_last_name', with: 'Such'
  click_on 'Create Contact'
  expect(page).to have_content('Contact was successfully created.')
end

Then(/^The contact for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Contact.where(id: u.id).first.first_name).to eq 'Artem'
  expect(Contact.where(id: u.id).first.last_name).to eq 'Suchov'
end

Then(/^I create the contact trough the case management$/) do
  click_on 'Case Management'
  click_on 'CONTACTS'
  click_on 'NEW CONTACT'
  fill_in 'contact_first_name', with: 'Artem'
  fill_in 'contact_last_name', with: 'Such'
  click_on 'Create Contact'
  expect(page).to have_content('Contact was successfully created.')
end

Then(/^The contact for user with email "(.*?)" should be saved to the db with the right fields$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Contact.where(id: u.id).first.first_name).to eq 'Artem'
  expect(Contact.where(id: u.id).first.last_name).to eq 'Suchov'
end
