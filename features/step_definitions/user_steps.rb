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
  expect(page).to have_content('Welcome!')
  expect(page).to have_content('One last step before you are using your free case management software. We just need a few more details:')
end

#TODO select tag - rewrite
Then(/^when I fill in the modal window$/) do
  fill_in 'firm_name', with: 'RubyRiders'
  #select("#Attorney", :from => "#firm_contact_type")
  fill_in 'firm_phone', with: 'RubyRiders'
  click_on 'Get Started'
end

Then(/^I should logged in$/) do
  expect(page).to have_content('Welcome, Artem Suchov')
  expect(current_path).to eq dashboards_path
end
