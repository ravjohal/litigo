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
  visit '/users/sign_in'
  fill_in 'user_email', with: 'artem.suchov@gmail.com'
  fill_in 'user_password', with: 'password'
  click_on 'SIGN IN'
  expect(page).to have_content('Welcome!')
  expect(page).to have_content('We just need a few more details before using your case management software:')
end

Then(/^I get the confirmation email and confirm it$/) do
  email = ActionMailer::Base.cached_deliveries.last
  token = email.body.to_s.match(/3000\/(.+)">/x)[1]
  visit "/#{token}"
  sleep 0.5
end

#TODO select tag - rewrite
Then(/^when I fill in the modal window$/) do
  fill_in 'firm_name', with: 'RubyRiders'
  #select("#Attorney", :from => "#firm_contact_type")
  fill_in 'firm_phone', with: '4081234567'
  click_on 'Get Started'
end

Then(/^I should logged in$/) do
  expect(page).to have_content('Firm and Contact were successfully created.')
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
  click_on 'SIGN OUT'
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

When(/^Signup and Login$/) do
  step 'I visit sign up page'
  step 'I am a logged in user with email "artem.suchov@gmail.com" and password "password"'
  step 'I get the confirmation email and confirm it'
  step 'I should be logged in user'
  step 'when I fill in the modal window'
  step 'I should logged in'
end
