Given(/I populate task list form/) do
steps %{
  Then I click "Case Management"
  And I click "TASKS"
  And I click "Task List"
  And I click "Create New List"
  And I fill Task List form
}
end

When(/^I fill Task List form$/) do
  sleep 1
  fill_in 'task_list_name', with: 'Test Task List'
  within "#s2id_task_list_view_permission" do
    first('.select2-chosen').click
  end
  find(".select2-result-label", text: 'Author Only').click
  within "#s2id_task_list_amend_permission" do
    first('.select2-chosen').click
  end
  find(".select2-result-label", text: 'Author Only').click
  choose('task_list_task_import_automatic')
  click_on 'ADD TASK'
  page.execute_script(%($('#task_draft_1').find("input[name*='[name]']").val('Parent task')))
  page.execute_script(%($("input[name*='[due_term]']").val('3')))
  within '.conjunction-select' do
    first('.select2-chosen').click
  end
  find(".select2-result-label", text: 'before').click
  page.execute_script(%($("textarea[name*='[description]']").val('Parent task description')))
end

When(/^I add dependent task draft$/) do
  page.find(".glyphicon-plus").click
  page.execute_script(%($('.parent_task_draft_1').find("input[name*='[name]']").val('Dependent task')))
  page.execute_script(%($('.parent_task_draft_1').find("input[name*='[due_term]']").val('2')))
  within '.parent_task_draft_1' do
    within '.conjunction-select' do
      first('.select2-chosen').click
    end
  end
  find(".select2-result-label", text: 'after').click

  within '.parent_task_draft_1' do
    within "div[id*='anchor_date']" do
      first('.select2-chosen').click
    end
  end
  find(".select2-result-label", text: 'previous task').click

  page.execute_script(%($('.parent_task_draft_1').find("textarea[name*='[description]']").val('Dependent task description')))
end