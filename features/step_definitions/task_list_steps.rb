Then(/^I fill Task List form$/) do
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
  click_on 'Save'
  sleep 5
end