When /^I open new task list form$/ do
  step 'I click "Case Management"'
  step 'I click "TASKS"'
  step 'I click "TASK ITEMS"'
  step 'I click "Create New Task List"'
end

When(/^I populate task list form$/) do
  step 'I open new task list form'
  step 'I fill Task List form'
end

When(/^I populate task list form manual$/) do
  step 'I open new task list form'
  step 'I fill Task List form manual'
end

When(/^I fill Task List form$/) do
  sleep 0.5
  fill_in 'task_list_name', with: 'Test Task List'
  select 'Author Only', from: 'task_list_view_permission'
  select 'Author Only', from: 'task_list_amend_permission'
  choose 'task_list_task_import_automatic'
  sleep 0.5
  select 'Personal Injury', from: 'task_list_case_type'
  # choose 'task_list_case_creator_all_firm'
  click_on 'ADD TASK'
  step 'I fill task 1 row with name "Parent task" and description "Parent task description" and days "3"'
  step 'I fill task 2 row with name "Parent task 2" and description "Parent task 2 description" and days "23"'
end

When(/^I fill Task List form manual$/) do
  sleep 1
  fill_in 'task_list_name', with: 'Test Task List'
  select 'Everyone in the firm', from: 'task_list_view_permission'
  select 'Everyone in the firm', from: 'task_list_amend_permission'
  choose 'task_list_task_import_manual'
  click_on 'ADD TASK'
  step 'I fill task 1 row with name "Parent task" and description "Parent task description" and days "3"'
  step 'I add child to task row 1 with name "Child task 2" and description "Child task description 2" and days "2"'
  step 'I add child to task row 1 with name "Child task 1" and description "Child task description" and days "1"'
  step 'I fill task 2 row with name "Parent task 2" and description "Parent task 2 description" and days "23"'
end

When(/^I fill task (\d+) row with name "(.*?)" and description "(.*?)" and days "(.*?)"$/) do |id, name, description, day|
  page.execute_script(%($('#task_draft_#{id}').find("input[name*='[name]']").val('#{name}')))
  page.execute_script(%($('#task_draft_#{id}').find("textarea").val('#{description}')))
  page.execute_script(%($('#task_draft_#{id}').find("input[name*='[due_term]']").val('#{day}')))
  page.execute_script(%($('#task_draft_#{id}').find("select[name*='[conjunction]']").val('After')))
  page.execute_script(%($('#task_draft_#{id}').find("select[name*='[anchor_date]']").val('affair.created_at')))
end

When(/^I add child to task row (\d+) with name "(.*?)" and description "(.*?)" and days "(.*?)"$/) do |id, name, description, day|
  page.execute_script(%($('#task_draft_#{id}').find("a.add_fields").click()))
  page.execute_script(%($('.parent_task_draft_#{id}:first').find("input[name*='[name]']").val('#{name}')))
  page.execute_script(%($('.parent_task_draft_#{id}:first').find("textarea").val('#{description}')))
  page.execute_script(%($('.parent_task_draft_#{id}:first').find("input[name*='[due_term]']").val('#{day}')))
end

When /^I add new empty dependent task draft$/ do
  page.find('.glyphicon-plus').click
end

When(/^I add dependent task draft$/) do
  step 'I add new empty dependent task draft'
  page.execute_script(%($('.parent_task_draft_1').find("input[name*='[name]']").val('Dependent task')))
  page.execute_script(%($('.parent_task_draft_1').find("textarea[name*='[description]']").val('Dependent task description')))
  page.execute_script(%($('.parent_task_draft_1').find("input[name*='[due_term]']").val('2')))
end

When(/^I go to import saved task list$/) do
  step 'I click to tab "TASKS"'
  step 'I click "TASK ITEMS"'
  step 'I click "Import Saved Task List"'
  sleep 0.1
end

When(/^I fill import list?/) do
  sleep 0.1
  page.execute_script(%($("input.import_task_lists").attr('checked', 'checked')))
  sleep 0.1
end