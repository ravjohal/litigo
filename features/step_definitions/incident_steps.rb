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

When /^I fill incident form field$/ do
  fill_in 'incident_incident_date', with: '12.12.2015'
  fill_in 'incident_location', with: 'Alabama'
  fill_in 'incident_defendant_liability', with: '80'
end

When /^I fill lead incident form field$/ do
  fill_in 'incident_incident_date', with: '12.12.2015'
  fill_in 'incident_location', with: 'Alabama'
  fill_in 'incident_defendant_liability', with: '80'
end

When /^I fill incident form field for update$/ do
  fill_in 'incident_incident_date', with: '10.10.2015'
  fill_in 'incident_location', with: 'Alabama2'
  fill_in 'incident_defendant_liability', with: '90'
end

Then(/^I create the incident$/) do
  click_on 'Case Management'
  click_on 'CASES'
  click_on 'some'
  click_on 'INCIDENT'
  sleep 0.5
  click_on 'Edit'
  step 'I fill incident form field'
  click_on 'Save'
end

Then /^I verify saved case incident$/ do
  _case = Case.last
  incident = _case.incident
  expect(incident).to_not be_nil
  expect(incident.location).to eq 'Alabama'
  expect(incident.defendant_liability.to_f).to eq 80.0
  expect(incident.incident_date.strftime('%F')).to eq '2015-12-12'
end

Then /^I verify updated case incident$/ do
  _case = Case.last
  incident = _case.incident
  expect(incident).to_not be_nil
  expect(incident.location).to eq 'Alabama2'
  expect(incident.defendant_liability.to_f).to eq 90.0
  expect(incident.incident_date.strftime('%F')).to eq '2015-10-10'
end

Then(/^The incident for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).last
  incident = Incident.where(id: u.id).last
  expect(incident).to_not be_nil
  expect(incident.location).to eq 'Alabama'
  expect(incident.defendant_liability.to_f).to eq 80.0
  expect(incident.incident_date.strftime('%F')).to eq '2015-12-12'
end