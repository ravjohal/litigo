When(/^I create the task$/) do
  step 'I open create task modal'
  fill_in 'task_name', with: 'My firs task'
  step 'I select first item from "task_select"'
  step 'I select first item from "secondary_owner_select"'
  fill_in 'task_due_date', with: '12.12.2014'
  fill_in 'task_description', with: 'Task description'
  # uncheck 'task_add_event'
  click_on 'Create Task'
end

When /^I open create task modal$/ do
  visit '/tasks'
  click_on 'TASK ITEMS'
  click_on 'New Task'
end

When(/^I create the task with calendar$/) do
  step 'I open create task modal'
  fill_in 'task_name', with: 'My firs task'
  step 'I select first item from "secondary_owner_select"'
  fill_in 'task_due_date', with: '12.12.2014'
  fill_in 'task_description', with: 'Task description'
  step 'I select first item from "task_calendar_id"'
  click_on 'Create Task'
end

When(/^I create the case task with calendar$/) do
  step 'I open create task modal'
  fill_in 'task_name', with: 'My firs task'
  step 'I select first item from "task_select"'
  step 'I select first item from "secondary_owner_select"'
  fill_in 'task_due_date', with: '12.12.2014'
  fill_in 'task_description', with: 'Task description'
  step 'I select first item from "task_calendar_id"'
  click_on 'Create Task'
end

Then(/^The task for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  task = Task.where(id: u.id).first
  expect(task.name).to eq 'My firs task'
  expect(simple_input_format_date(task.due_date)).to eq '2014-12-12'
  expect(task.description).to eq 'Task description'
  expect(task.case_id.to_i).to eq 1
  expect(task.secondary_owner_id.to_i).to eq 1
end

Then(/^I create the task through case management$/) do
  step 'I go to tasks'
  click_on 'TASK ITEMS'
  click_on 'New Task'
  fill_in 'task_name', with: 'some name'
  step 'I select first item from "secondary_owner_select"'
  fill_in 'task_due_date', with: '12.12.2014'
  fill_in 'task_description', with: 'Task description'
  # uncheck 'task_add_event'
  click_on 'Create Task'
end

Then(/^The task for user with email "(.*?)" should be saved to the db with the right fields$/) do |arg1|
  u = User.where(email: arg1).first
  task = Task.where(id: u.id).first
  expect(task.name).to eq 'some name'
  expect(simple_input_format_date(task.due_date)).to eq '2014-12-12'
  expect(task.description).to eq 'Task description'
  expect(task.case_id.to_i).to eq 0
  expect(task.secondary_owner_id.to_i).to eq 1
end

Given(/^Default task exist$/) do
  step 'Default task exist for user: "artem.suchov@gmail.com"'
end

Given(/^Default task exist for user: "(.*?)"$/) do |email|
  user = User.find_by :email => email
  firm = user.firm
  _case = user.cases.last
  FactoryGirl.create(:task, user: user, firm: firm, owner: user, case: _case)
end

When /^I go to tasks$/ do
  step 'I open case management menu'
  click_on 'Tasks'
end

When /^I go to first task$/ do
  step 'I go to tasks'
  step 'I click to element with selector "#my_tasks tr > td"'
end

When /^I fill task form$/ do
  fill_in 'task_name', with: 'New_Task_Name'
  fill_in 'task_due_date', with: '12.12.2017'
  fill_in 'task_estimated_time', with: '100'
  select 'Hour(s)', from: 'task_estimated_time_unit'
  fill_in 'task_completed', with: '12.12.2018'
  fill_in 'task_description', with: 'NewTaskDescription'
end

Then /^The task should be edited success$/ do
  task = Task.last
  expect(task.name).to eq 'New_Task_Name'
  expect(task.description).to eq 'NewTaskDescription'
  expect(task.estimated_time).to eq 100.0
  expect(task.estimated_time_unit).to eq 'Hour(s)'
  expect(simple_input_format_date(task.due_date)).to eq '2017-12-12'
  expect(simple_input_format_date(task.completed)).to eq '2018-12-12'
end

Then /^User tasks should be empty for email "(.*?)"$/ do |email|
  user = User.find_by email: email
  expect(Task.where(user_id: user.id).count).to eq(0)
end