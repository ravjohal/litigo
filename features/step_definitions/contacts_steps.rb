Then(/^I create the contact$/) do
  visit '/contacts'
  click_on 'NEW CONTACT'
  find("option[value='Attorney']").click
  fill_in 'contact_first_name', with: 'Artem'
  fill_in 'contact_last_name', with: 'Such'
  click_on 'Create Contact'
  expect(page).to have_content('Contact was successfully created.')
end

When /^I go to contacts$/ do
  step 'I open case management menu'
  click_on 'CONTACTS'
end

Then(/^The contact for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Contact.where(id: u.id).first.first_name).to eq 'Artem'
  expect(Contact.where(id: u.id).first.last_name).to eq 'Suchov'
end

Then(/^I create the contact trough the case management$/) do
  step 'I open case management menu'
  click_on 'CONTACTS'
  click_on 'NEW CONTACT'
  fill_in 'contact_first_name', with: 'Artem'
  fill_in 'contact_last_name', with: 'Such'
  click_on 'Create Contact'
  expect(page).to have_content('Contact was successfully created.')
end

Then(/^I create the similar contact trough the case management$/) do
  click_on 'NEW CONTACT'
  fill_in 'contact_first_name', with: 'Artem'
  fill_in 'contact_last_name', with: 'Such'
  click_on 'Create Contact'
  expect(page).to have_content(I18n.t('contact.notice.similar_list'))
end

Then(/^The contact for user with email "(.*?)" should be saved to the db with the right fields$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Contact.where(id: u.id).first.first_name).to eq 'Artem'
  expect(Contact.where(id: u.id).first.last_name).to eq 'Suchov'
end

When /^I fill edit contact form$/ do
  fill_in 'contact_address', with: 'Contact Address'
  fill_in 'contact_city', with: 'Contact City'
  select 'Alabama', from: 'contact_state'
  fill_in 'contact_zip_code', with: '23456789'
  fill_in 'contact_email', with: 'example@example.com'
  # fill_in 'contact_phone_number', with: '(888) 888-8888'
  # fill_in 'contact_mobile', with: '(888) 888-8888'
  page.execute_script(%($('#contact_phone_number').val('(888) 888-8888')))
  page.execute_script(%($('#contact_mobile').val('(888) 888-8888')))
  select 'Attorney', from: 'contact_type'
  select 'Mr.', from: 'contact_prefix'
  fill_in 'contact_first_name', with: 'FirstName'
  fill_in 'contact_last_name', with: 'LastName'
  fill_in 'contact_middle_name', with: 'MiddleName'
  choose 'contact_gender_m'
  fill_in 'contact_date_of_birth', with: '12.12.2014'
  fill_in 'contact_ssn', with: '1234567890'
  fill_in 'contact_major_date', with: '12.12.2014'
  fill_in 'contact_date_of_death', with: '12.12.2014'
  fill_in 'contact_job_description', with: 'Job Description'
  fill_in 'contact_salary', with: '123456'
  select 'Hour', from: 'contact_time_bound'
  fill_in 'contact_note', with: 'Contact Note'
end

Then /^The contact info should be saved$/ do
  contact = Contact.last
  expect(contact.address).to eq('Contact Address')
  expect(contact.city).to eq('Contact City')
  expect(contact.state).to eq('AL')
  expect(contact.zip_code).to eq('23456789')
  expect(contact.email).to eq('example@example.com')
  expect(contact.phone_number).to eq('(888) 888-8888')
  expect(contact.mobile).to eq('(888) 888-8888')
  expect(contact.type).to eq('Attorney')
  expect(contact.prefix).to eq('Mr.')
  expect(contact.first_name).to eq('FirstName')
  expect(contact.last_name).to eq('LastName')
  expect(contact.middle_name).to eq('MiddleName')
  expect(contact.gender).to eq('M')
  expect(simple_input_format_date(contact.date_of_birth)).to eq('2014-12-12')
  expect(contact.ssn).to eq('1234567890')
  expect(simple_input_format_date(contact.major_date)).to eq('2014-12-12')
  expect(simple_input_format_date(contact.date_of_death)).to eq('2014-12-12')
  expect(contact.job_description).to eq('Job Description')
  expect(contact.salary.to_f).to eq 123456.0
  expect(contact.time_bound).to eq('Hour')
  expect(contact.note).to eq('Contact Note')
end

Then /^User contacts should be empty for email "(.*?)"$/ do |email|
  user = User.find_by email: email
  expect(Contact.where(user_id: user.id).count).to eq(0)
end