When /^I go to events page$/ do
  visit '/events'
end

When /^I go to calendar events page$/ do
  click_on 'CALENDAR'
end

When /^I open create event popup$/ do
  click_on 'NEW EVENT'
end

When /^I fill event without calendar$/ do
  fill_in 'event_title', with: 'NewEvent1'
  fill_in 'event_location', with: 'NewEventLocation1'

  starts_date = Time.now + 65.minutes
  ends_date = Time.now + 95.minutes

  step "I fill input \"event_start_date\" with value \"#{date_to_input_with_zero(starts_date)}\""
  step "I fill input \"event_start_time\" with value \"#{time_to_input(starts_date)}\""

  step "I fill input \"event_end_date\" with value \"#{date_to_input_with_zero(ends_date)}\""
  step "I fill input \"event_end_time\" with value \"#{time_to_input(ends_date)}\""

  fill_in 'event_description', with: 'SomeDescription1'

  click_on 'Create Event'
end

When /^I fill event with calendar$/ do
  step 'I select first item from "event_calendar_id"'
  sleep 0.2
  step 'I fill event without calendar'
end

When /^I add simple all_day event$/ do
  step 'I open create event popup'
  step 'I select first item from "event_calendar_id"'
  fill_in 'event_title', with: 'Simple event'
  fill_in 'event_location', with: 'Simple location'
  page.execute_script(%($('#invitee_select').val('litigo2test@gmail.com')))
  page.execute_script(%($('#invitee_select + ul > li > input').val('litigo2test@gmail.com')))
  fill_in 'event_start_date', with: date_to_input(2.day.from_now)
  fill_in 'event_end_date', with: date_to_input(2.day.from_now)
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

Then /^I verify calendar event popup shown$/ do
  expect(page).to have_content 'Calendar Event'
  expect(page).to have_css('div#modal-window')
  expect(page).to have_css('form#new_event')
end

Then /^I verify calendar event was created$/ do
  event = Event.last

  expect(event).to_not be_nil
  expect(event.title).to eq 'NewEvent1'
  expect(event.location).to eq 'NewEventLocation1'
  expect(event.description).to eq 'SomeDescription1'

  starts_date = Time.now + 65.minutes
  ends_date = Time.now + 95.minutes

  expect(date_to_input_with_zero(event.starts_at)).to eq date_to_input_with_zero(starts_date)
  expect(time_to_input(event.starts_at)).to eq time_to_input(starts_date)

  expect(date_to_input_with_zero(event.ends_at)).to eq date_to_input_with_zero(ends_date)
  expect(time_to_input(event.ends_at)).to eq time_to_input(ends_date)
  end

Then /^I verify event with calendar event was created$/ do
  event = Event.last

  expect(event).to_not be_nil
  expect(event.calendar_id).to_not be_nil
  expect(event.title).to eq 'NewEvent1'
  expect(event.location).to eq 'NewEventLocation1'
  expect(event.description).to eq 'SomeDescription1'

  starts_date = Time.now + 65.minutes
  ends_date = Time.now + 95.minutes

  expect(date_to_input_with_zero(event.starts_at)).to eq date_to_input_with_zero(starts_date)
  expect(time_to_input(event.starts_at)).to eq time_to_input(starts_date)

  expect(date_to_input_with_zero(event.ends_at)).to eq date_to_input_with_zero(ends_date)
  expect(time_to_input(event.ends_at)).to eq time_to_input(ends_date)
end

Then /^I verify created event shown fields$/ do
  starts_date = Time.now + 65.minutes
  ends_date = Time.now + 95.minutes

  expect(find('#event_title').value).to eq 'NewEvent1'
  expect(find('#event_location').value).to eq 'NewEventLocation1'
  expect(find('#event_description').value).to eq 'SomeDescription1'

  expect(find('#event_start_date').value).to eq(date_to_input_with_zero(starts_date))
  expect(find('#event_start_time').value).to eq(time_to_input(starts_date))

  expect(find('#event_end_date').value).to eq(date_to_input_with_zero(ends_date))
  expect(find('#event_end_time').value).to eq(time_to_input(ends_date))
end

Then /^I verify event placed to nylas$/ do
  event = Event.last
  namespace = Namespace.last

  nylas_namespace = namespace.nylas_namespace
  ne = nylas_namespace.events.find(event.nylas_event_id)

  expect(ne).to_not be_nil
  expect(ne.description).to eq event.description
  expect(ne.location).to eq event.location
  expect(ne.read_only).to eq event.read_only
  expect(ne.title).to eq event.title
  expect(ne.when['start_time']).to eq event.starts_at.to_i
  expect(ne.when['end_time']).to eq event.ends_at.to_i
end