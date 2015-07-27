Then(/^I create the task$/) do
  visit '/tasks'
  click_on 'TASK ITEMS'
  click_on 'New Task'
  fill_in 'task_name', with: 'My firs task'
  click_on 'Create Task'
  expect(page).to have_content('Task successfully created.')
end

Then(/^The task for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Task.where(id: u.id).first.name).to eq 'My firs task'
end

Then(/^I create the task through case management$/) do
  click_on 'Case Management'
  click_on 'TASKS'
  click_on 'TASK ITEMS'
  click_on 'New Task'
  fill_in 'task_name', with: 'some name'
  click_on 'Create Task'
  expect(page).to have_content('Task successfully created.')
end

Then(/^The task for user with email "(.*?)" should be saved to the db with the right fields$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Task.where(id: u.id).first.name).to eq 'some name'
end