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
  step "I should be just login with email \"#{email}\" and password \"#{password}\""
  expect(page).to have_content('Welcome!')
  expect(page).to have_content('We just need a few more details before using your case management software:')
end

When(/^I should be just login with email "(.*?)" and password "(.*?)"$/) do |email, password|
  visit '/users/sign_in'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_on 'SIGN IN'
  user = User.find_by email: email
  Time.zone = user.time_zone if user
end

Then(/^I get the confirmation email and confirm it$/) do
  email = ActionMailer::Base.cached_deliveries.last
  token = email.body.to_s.match(/3000\/(.+)">/x)[1]
  visit "/#{token}"
  sleep 0.5
end

Then(/^I should receive confirmation email for user "(.*?)"$/) do |user_email|
  email = ActionMailer::Base.cached_deliveries.last
  expect(email.to[0].to_s).to eq user_email
  expect(email.subject.to_s).to eq 'Confirmation instructions'
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
  _user = FactoryGirl.create(:user, first_name: first_name, last_name: last_name, name: "#{first_name} #{last_name}", email: email, password: password, confirmed_at: Time.now)
end

Given(/^Confirmed admin user exists with first name "(.*?)", last name "(.*?)", email "(.*?)" and password "(.*?)"$/) do |first_name, last_name, email, password|
  FactoryGirl.create(:admin_user, first_name: first_name, last_name: last_name, name: "#{first_name} #{last_name}", email: email, password: password, confirmed_at: Time.now)
end

Given(/^Confirmed invited user exists with first name "(.*?)", last name "(.*?)", email "(.*?)" and password "(.*?)" for user with email "(.*?)"$/) do |first_name, last_name, email, password, admin_user|
  _user = User.find_by email: admin_user
  FactoryGirl.create(:invited_user, first_name: first_name, last_name: last_name, name: "#{first_name} #{last_name}", email: email, password: password, confirmed_at: Time.now, firm_id: _user.firm_id, invited_by_id: _user.id)
end

Given(/^Confirmed firm user exists with first name "(.*?)", last name "(.*?)", email "(.*?)" and password "(.*?)" for user with email "(.*?)"$/) do |first_name, last_name, email, password, admin_user|
  _user = User.find_by email: admin_user
  FactoryGirl.create(:user, first_name: first_name, last_name: last_name, name: "#{first_name} #{last_name}", email: email, password: password, confirmed_at: Time.now, firm_id: _user.firm_id)
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

  user.create_contact :attorney.to_s.humanize, firm
end

When(/^I fill in the sign up form with invalid data$/) do
  fill_in 'user_first_name', with: 'Artem'
  fill_in 'user_last_name', with: 'Suchov'
  fill_in 'user_email', with: 'artem.suchovgmail.com'
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  click_on 'SIGN UP'
end

When(/^I fill in the sign in form with second user$/) do
  step "I should be just login with email \"andrew.suchov@gmail.com\" and password \"password\""
end

Then(/^I should see the sign_up form again$/) do
  expect(current_path).to eq new_user_registration_path
end

When /^I make sign out$/ do
  step 'I click to element with id "userMenuDropdown"'
  step 'I go to sign_out page'
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
  step "I should be just login with email \"#{arg1}\" and password \"#{arg2}\""
  expect(page).to have_content('Welcome!')
  expect(page).to have_content('We just need a few more details before using your case management software:')
end

When(/^I sign up and login$/) do
  step 'I visit sign up page'
  step 'I am a logged in user with email "artem.suchov@gmail.com" and password "password"'
  step 'I get the confirmation email and confirm it'
  step 'I should be logged in user'
  step 'I fill in the modal window'
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
  sleep 0.1
  page.execute_script(%($("input[name*='[email]']").val('#{email}')))
  sleep 0.1
end

When(/^I change invited user role field$/) do
  within '#edit_user_2' do
    select 'Staff', from: 'user_role'
    click_on 'Change Role'
  end
end

When /^I to to invite users page$/ do
  step 'I click on "Add Users to Firm"'
  sleep 0.5
end

When /^I fill new invited user form for user with email "(.*?)" and password "(.*?)"$/ do |email, password|
  fill_in 'user_first_name', with: 'Test'
  fill_in 'user_last_name', with: 'Test'
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password
  click_on 'Set my password'
end


Then(/it should be database record for invited user "(.*?)" from "(.*?)"/) do |invited_email, user_email|
  user = User.where(email: user_email).pluck(:id)
  expect(User.where(email: invited_email, invited_by_id: user[0]).count).to eq(1)
end

Then(/user with email "(.*?)" should have role "(.*?)"/) do |email, role|
  expect(User.where(email: email).first.role).to eq(role)
end

Then /^I verify invited firm user$/ do
  firm = Firm.last
  expect(firm.users.count).to eq 2
end

Then /^Invite email should be sended to "(.*?)"$/ do |_email|
  email = ActionMailer::Base.cached_deliveries.last
  expect(email.to[0].to_s).to eq _email
  expect(email.subject).to eq 'Invitation instructions'
end