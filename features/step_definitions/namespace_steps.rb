When /^I add namespace with email "(.*?)" and password "(.*?)"$/ do |email, password|
  click_on 'Profile'
  click_on 'CALENDARS'
  click_on 'ADD ACCOUNT'
end

When /^I add simple namespace$/ do
  step 'I add namespace with email "litigo1test@gmail.com" and password "password_litigo"'
end