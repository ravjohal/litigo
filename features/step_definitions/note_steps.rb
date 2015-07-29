Given /^Default note exist$/ do
  user = User.last
  FactoryGirl.create(:note, user: user, firm: user.firm)
end

Given /^Default case note exist$/ do
  user = User.last
  _case = user.cases.last
  FactoryGirl.create(:note, user: user, firm: user.firm, case: _case)
end


When /^I go to notes/ do
  click_on 'Case Management'
  click_on 'NOTES'
end


When /^I go to first note$/ do
  step 'I go to notes'
  step 'I click to element with selector "#tasks tr > td > a"'
end

When(/^I create a note$/) do
  visit '/notes'
  click_on 'NEW NOTE'
  find("option[value='Medical/Review']").click
  fill_in 'note_note', with: 'TestNote'
  click_on 'Create Note'
  expect(page).to have_content('Note was successfully created.')
end

When(/^I create a note with task$/) do
  visit '/notes'
  click_on 'NEW NOTE'
  find("option[value='Medical/Review']").click
  fill_in 'note_note', with: 'TestNote'
  check 'note_add_task'
  fill_in 'note_task_name', with: 'NewNoteTaskName'
  fill_in 'note_task_due_date', with: '12.12.2015'
  fill_in 'note_task_description', with: 'NewNoteTaskDescription'
  uncheck 'note_task_add_event'
  click_on 'Create Note'
  expect(page).to have_content('Note was successfully created.')
end

When(/^I create a case note$/) do
  visit '/notes'
  click_on 'NEW NOTE'
  find("option[value='Medical/Review']").click
  fill_in 'note_note', with: 'TestNote'
  click_on 'Create Note'
  expect(page).to have_content('Note was successfully created.')
end

When(/^I create a note from case$/) do
  step 'I click to tab "NOTES"'
  click_on 'NEW NOTE'
  find("option[value='Medical/Review']").click
  fill_in 'note_note', with: 'TestNote'
  click_on 'Create Note'
  expect(page).to have_content('Note was successfully created.')
end

When(/^I edit a note$/) do
  find("option[value='Medical/Review']").click
  fill_in 'note_note', with: 'NewTestNote'
end

Then(/^The note should be edited for user with email "(.*?)"$/) do |email|
  u = User.where(email: email).first
  note = Note.where(id: u.id).first
  expect(note.note_type).to eq 'Medical/Review'
  expect(note.note).to eq 'NewTestNote'
end

Then(/^The note for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  note = Note.where(id: u.id).first
  expect(note.note_type).to eq 'Medical/Review'
  expect(note.author).to eq 'Artem Suchov'
  expect(note.note).to eq 'TestNote'
  expect(note.case_id.to_i).to eq 0
end

Then(/^The note with task for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  note = u.notes.first
  expect(note.note_type).to eq 'Medical/Review'
  expect(note.author).to eq 'Artem Suchov'
  expect(note.note).to eq 'TestNote'
  expect(note.case_id.to_i).to eq 0

  task = u.tasks.first
  expect(task.name).to eq 'NewNoteTaskName'
  expect(task.description).to eq 'NewNoteTaskDescription'
  expect(task.due_date.strftime('%F')).to eq '2015-12-12'
end

Then(/^The case note for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  note = Note.where(id: u.id).first
  _case = u.cases.last
  expect(note.note_type).to eq 'Medical/Review'
  expect(note.author).to eq 'Artem Suchov'
  expect(note.note).to eq 'TestNote'
  expect(note.case_id).to eq _case.id
end