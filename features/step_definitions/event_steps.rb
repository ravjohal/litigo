When /^I go to events page$/ do
  visit '/events'
end

When /^I add simple all_day event$/ do
  click_on 'NEW EVENT'
  step 'I select first item from "event_calendar_id"'
  fill_in 'event_title', with: 'Simple event'
  fill_in 'event_location', with: 'Simple location'
  page.execute_script(%($('#invitee_select').val('litigo2test@gmail.com')))
  page.execute_script(%($('#invitee_select + ul > li > input').val('litigo2test@gmail.com')))
  fill_in 'event_start_date', with: 2.day.from_now.strftime('%m/%d/%Y')
  fill_in 'event_end_date', with: 2.day.from_now.strftime('%m/%d/%Y')
  check 'event_all_day'
  fill_in 'event_description', with: 'Simple description'
  click_on 'Create Event'
  sleep 10
end

When /^I sync events$/ do
  step 'I click to element with id "sync"'
  sleep 15
end

When /^I remove participant in event "(.*?)"$/ do |event_name|
  find('span', :text => event_name).click
  sleep 10
  page.execute_script(%($('#invitee_select').val('')))
  page.execute_script(%($('#invitee_select + ul > li > input').val('')))
  click_on 'Update Event'
  sleep 15
end

Then /^I verify last synced events$/ do
  event = Event.last
  expect(event.all_day).to be true
end

Then /^I should verify removed event to user "(.*?)"$/ do |email|
  user = User.find_by email: email
  pending
end