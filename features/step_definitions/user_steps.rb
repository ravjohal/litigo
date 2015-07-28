Given(/^I am a guest$/) do
end

When(/^I visit sign up page$/) do
  visit '/users/sign_up'
end

When(/^I fill in the sign up form with valid data$/) do
  fill_in 'user_first_name', with: 'Artem'
  fill_in 'user_last_name', with: 'Suchov'
  fill_in 'user_email', with: 'artem.suchov@gmail.com'
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  click_on 'SIGN UP'
end

Then(/^I should be logged in user$/) do
  step 'I should be logged in user with email "artem.suchov@gmail.com" and password "password"'
end

When(/^I should be logged in user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  visit '/users/sign_in'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_on 'SIGN IN'
  expect(page).to have_content('Welcome!')
  expect(page).to have_content('We just need a few more details before using your case management software:')
end

When(/^I should be just login with email "(.*?)" and password "(.*?)"$/) do |email, password|
  visit '/users/sign_in'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_on 'SIGN IN'
end

Then(/^I get the confirmation email and confirm it$/) do
  email = ActionMailer::Base.cached_deliveries.last
  token = email.body.to_s.match(/3000\/(.+)">/x)[1]
  visit "/#{token}"
  sleep 0.5
end

#TODO select tag - rewrite
Then(/^I fill in the modal window$/) do
  fill_in 'firm_name', with: 'RubyRiders'
  #select("#Attorney", :from => "#firm_contact_type")
  fill_in 'firm_phone', with: '4081234567'
  click_on 'Get Started'
end

Then(/^I should logged in$/) do
  expect(page).to have_content('Firm and Contact were successfully created.')
end

Given(/^Confirmed user exists with first name "(.*?)", last name "(.*?)", email "(.*?)" and password "(.*?)"$/) do |first_name, last_name, email, password|
  FactoryGirl.create(:user, first_name: first_name, last_name: last_name, email: email, password: password, confirmed_at: Time.now)
end

Given(/^Confirmed admin user exists with first name "(.*?)", last name "(.*?)", email "(.*?)" and password "(.*?)"$/) do |first_name, last_name, email, password|
  FactoryGirl.create(:admin_user, first_name: first_name, last_name: last_name, email: email, password: password, confirmed_at: Time.now)
end

Given(/^Confirmed invited user exists with first name "(.*?)", last name "(.*?)", email "(.*?)" and password "(.*?)" for user with email "(.*?)"$/) do |first_name, last_name, email, password, admin_user|
  _user = User.find_by email: admin_user
  FactoryGirl.create(:invited_user, first_name: first_name, last_name: last_name, email: email, password: password, confirmed_at: Time.now, firm_id: _user.firm_id, invited_by_id: _user.id)
end

Given(/^Confirmed firm user exists with first name "(.*?)", last name "(.*?)", email "(.*?)" and password "(.*?)" for user with email "(.*?)"$/) do |first_name, last_name, email, password, admin_user|
  _user = User.find_by email: admin_user
  FactoryGirl.create(:user, first_name: first_name, last_name: last_name, email: email, password: password, confirmed_at: Time.now, firm_id: _user.firm_id)
end

Given(/^Confirmed default user exists$/) do
  step 'Confirmed user exists with first name "Artem", last name "Suchov", email "artem.suchov@gmail.com" and password "password"'
end

Given(/^Confirmed default admin user exists$/) do
  step 'Confirmed admin user exists with first name "Artem", last name "Suchov", email "artem.suchov@gmail.com" and password "password"'
end

Given(/^Confirmed default invited user for default user$/) do
  step 'Confirmed invited user exists with first name "Andrew", last name "Suchov", email "andrew.suchov@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"'
end

Given(/^Firm for default user exist$/) do
  step 'Firm exist for user: "artem.suchov@gmail.com"'
end

Given(/^Firm exist for user: "(.*?)"$/) do |email|
  firm = FactoryGirl.create(:firm)
  user = User.find_by :email => email
  user.firm = firm
  user.save!
end

When(/^I fill in the sign up form with invalid data$/) do
  fill_in 'user_first_name', with: 'Artem'
  fill_in 'user_last_name', with: 'Suchov'
  fill_in 'user_email', with: 'artem.suchovgmail.com'
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  click_on 'SIGN UP'
end

Then(/^I should see the sign_up form again$/) do
  expect(current_path).to eq new_user_registration_path
end

Then(/^I go to sign_out page$/) do
  click_on 'Sign Out'
end

Then(/^I should be signed out$/) do
  expect(current_path).to eq root_path
  expect(page).to have_content 'SIGN IN'
end

Given(/^I am a logged in user with email "(.*?)" and password "(.*?)"$/) do |arg1, arg2|
  fill_in 'user_first_name', with: 'Artem'
  fill_in 'user_last_name', with: 'Suchov'
  fill_in 'user_email', with: arg1
  fill_in 'user_password', with: arg2
  fill_in 'user_password_confirmation', with: 'password'
  click_on 'SIGN UP'
end


When (/^I log in with email "(.*?)" and password "(.*?)"$/) do |arg1, arg2|
  visit '/users/sign_in'
  fill_in 'user_email', with: arg1
  fill_in 'user_password', with: arg2
  click_on 'SIGN IN'
  expect(page).to have_content('Welcome!')
  expect(page).to have_content('We just need a few more details before using your case management software:')
end

When(/^I sign up and login$/) do
  step 'I visit sign up page'
  step 'I am a logged in user with email "artem.suchov@gmail.com" and password "password"'
  step 'I get the confirmation email and confirm it'
  step 'I should be logged in user'
  step 'when I fill in the modal window'
  step 'I should logged in'
end

When(/^I login$/) do
  step 'I should be logged in user with email "artem.suchov@gmail.com" and password "password"'
  step 'I fill in the modal window'
  step 'I should logged in'
end

When(/^I login without firm$/) do
  step 'I should be just login with email "artem.suchov@gmail.com" and password "password"'
end

When(/^I login with email "(.*?)" and password "(.*?)"$/) do |email, password|
  step "I should be logged in user with email \"#{email}\" and password \"#{password}\""
end

When(/^I fill invite form with email "(.*?)"$/) do |email|
  page.execute_script(%($("input[name*='[email]']").val('#{email}')))
end

When(/^I change invited user role field$/) do
  within '#edit_user_2' do
    select 'Staff', from: 'user_role'
    click_on 'Change Role'
  end
end

Then(/it should be database record for invited user "(.*?)" from "(.*?)"/) do |invited_email, user_email|
  user = User.where(email: user_email).pluck(:id)
  expect(User.where(email: invited_email, invited_by_id: user[0]).count).to eq(1)
end

Then(/user with email "(.*?)" should have role "(.*?)"/) do |email, role|
  expect(User.where(email: email).first.role).to eq(role)
end

When(/^I click to user dropdown$/) do
  page.execute_script(%($('#dropdownMenu1').click()))
end

Then /^I should see a JS alert$/ do
  expect(page.driver.browser.switch_to.alert).to_not be_nil
end

Then /^I should not see a JS alert$/ do
  alert = driver.switch_to.alert rescue 'exception happened'
  expect(alert).to eq('exception happened')
end

Then /^I should see a "(.*?)" JS alert dialog$/ do |text|
  expect(page.driver.browser.switch_to.alert.text).to eql(text)
end

When /^I should close alert$/ do
  page.driver.browser.switch_to.alert.accept
end

When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end

When /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end