When(/^I visit home page$/) do
  visit root_path
end

Then(/^the page should show "(.*?)"$/) do |content|
  expect(page).to have_content content
end