When /^I go to calendars$/ do
  click_on 'Profile'
  click_on 'CALENDARS'
end


When /^I add namespace with email "(.*?)" and password "(.*?)"$/ do |email, password|
  step 'I go to calendars'
  click_on 'ADD ACCOUNT'
  sleep 0.5

  fill_in 'login_hint', with: email
  click_on 'Sign In'
  sleep 0.5

  fill_in 'Email', with: email
  page.execute_script(%(document.getElementById('next').click()))
  sleep 0.5

  fill_in 'Passwd', with: password
  page.execute_script(%(document.getElementById('signIn').click()))
  sleep 40
end

When /^I activate calendars for simple namespace$/ do
  step 'I activate calendars for namespace "litigo1test@gmail.com"'
end

When /^I activate calendars for second simple namespace$/ do
  step 'I activate calendars for namespace "litigo2test@gmail.com"'
end

When /^I activate calendars for namespace "(.*?)"$/ do |namespace|
  find('td', :text => namespace).click
  sleep 0.1
  page.execute_script(%($('.calendar_ids').attr('checked', 'checked')))
  sleep 0.1
  click_on 'SYNC SELECTED CALENDARS'
  sleep 1
end

When /^I add simple namespace$/ do
  step 'I add namespace with email "litigo1test@gmail.com" and password "password_litigo"'
end

When /^I add second simple namespace$/ do
  step 'I add namespace with email "litigo2test@gmail.com" and password "password_litigo"'
end

When /^I delete simple namespace$/ do
  step 'I delete namespace "litigo1test@gmail.com"'
end

When /^I delete second simple namespace$/ do
  step 'I delete namespace "litigo2test@gmail.com"'
end

When /^I delete simple namespace calendar$/ do
  step 'I delete calendar "litigo1test@gmail.com" in namespace "litigo1test@gmail.com"'
end

When /^I delete second simple namespace calendar$/ do
  step 'I delete calendar "litigo2test@gmail.com" in namespace "litigo2test@gmail.com"'
end

When /^I delete namespace "(.*?)"$/ do |namespace|
  step 'I go to calendars'
  sleep 20
  # find('td', :text => namespace).find(:xpath, './/..').find('a').click
  page.execute_script(%($('a.delete').click()))
  step 'I confirm popup'
  sleep 10
end

When /^I delete calendar "(.*?)" in namespace "(.*?)"$/ do |calendar, namespace|
  step 'I go to calendars'
  sleep 20
  find('td', :text => namespace).click
  sleep 10
  # find('td', :text => calendar).find(:xpath, './/..').find('a').click
  page.execute_script(%($('a.delete').click()))
  step 'I confirm popup'
  sleep 10
end

Then /^I verify simple namespace created for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  namespace = user.namespaces.last

  expect(namespace.email_address).to eq 'litigo1test@gmail.com'
  expect(namespace.provider).to eq 'gmail'
  expect(namespace.name).to eq 'Test Test'
  expect(namespace.enabled_calendars.count).to eq 1
end

Then /^I verify downloading calendar for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  calendar = user.enabled_calendars.last
  expect(calendar.name).to eq 'litigo1test@gmail.com'
end

Then /^I verify namespace event count for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  calendar = user.enabled_calendars.last
  expect(calendar.events.count).to eq 1
end

Then /^I verify deleted namespace for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  expect(user.namespaces.size).to eq 0
  expect(user.calendars.size).to eq 0
  expect(user.events.size).to eq 0
end

Then /^I verify deleted calendar for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  expect(user.enabled_calendars.size).to eq 0
  expect(user.events.size).to eq 0
end

Then /^I should have created namespace for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  expect(user.namespaces.size).to eq 1
  expect(user.calendars.size).to eq 1
end

Then /^Calendar should by synced for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  expect(user.events.size > 0).to be_true
end