Given(/^Default namespace exist for user "(.*?)"$/) do |email|
  user = User.find_by email: email
  FactoryGirl.create(:namespace, user: user, firm: user.firm)
end

Given(/^Default namespace exist for default user$/) do
  step 'Default namespace exist for user "artem.suchov@gmail.com"'
end

Given(/^Default calendar exist for user "(.*?)"$/) do |email|
  user = User.find_by email: email
  FactoryGirl.create(:calendar, firm: user.firm, namespace: user.namespaces.last)
end

Given(/^Default disabled calendar exist for user "(.*?)"$/) do |email|
  user = User.find_by email: email
  FactoryGirl.create(:disabled_calendar, firm: user.firm, namespace: user.namespaces.last)
end

Given(/^Default calendar exist for default user$/) do
  step 'Default calendar exist for user "artem.suchov@gmail.com"'
end

Given(/^Default disabled calendar exist for default user$/) do
  step 'Default disabled calendar exist for user "artem.suchov@gmail.com"'
end