Then (/^I see dashboard with creation quick-links$/) do
  expect(page).to have_content('New Caller Intake')
  expect(page).to have_content('New Case')
  expect(page).to have_content('New Contact')
  expect(page).to have_content('New Task')
  expect(page).to have_content('New Document')
  expect(page).to have_content('New Note')
end

Then (/^I return to dashboard$/) do
  visit '/'
end

When (/^I fill Client Intake modal$/) do
  fill_in 'lead_first_name', with: 'First'
  fill_in 'lead_last_name', with: 'Last'
  page.execute_script(%Q{ $('input#lead_phone').val('(123) 456-7890'); })
  select 'Radio', from: 'lead_marketing_channel'
  fill_in 'lead_note', with: 'Some note'
  click_on 'Create Lead'
end

When (/^I fill Case modal$/) do
  fill_in 'case_name', with: 'Case'
  first('.controls').click
  # select Attorney
  within '.contacts_select' do
    first('.select2-choices').click
  end
  find('.select2-result-label', text: 'Artem Suchov').click
  ####
  #fill_in 'case_county', with: 'County'
  # select State
  select 'Alabama', from: 'case_state'
  # select Case Type
  select 'Personal Injury', from: 'case_case_type'
  # select Case sub-type
  select 'Motor Vehicle', from: 'case_subtype'
  # set Incident date
  page.execute_script("$('#case_incident_attributes_incident_date').val('12.12.2014')")
  ####
  # fill_in 'case_medical_attributes_total_med_bills', with: '5000'
  # select Primary Injury
  # within ('#s2id_case_medical_attributes_injuries_attributes_0_injury_type') do
  #   first('.select2-default').click
  # end
  # find('.select2-result-label', text: 'TBI').click
  ####
  # select Primary Injury Region
  # within ('#s2id_case_medical_attributes_injuries_attributes_0_region') do
  #   first('.select2-default').click
  # end
  # find('.select2-result-label', text: 'Skull').click
  ####
  fill_in 'case_topic', with: 'Case topic'
  fill_in 'case_description', with: 'Case summary'
  click_on 'Create Case'
end

Then (/^lead should be created$/) do
  expect(Lead.where(first_name: 'First', last_name: 'Last')).to exist
  lead = Lead.last
  expect(lead.first_name).to eq('First')
  expect(lead.last_name).to eq('Last')
  expect(lead.phone).to eq('(123) 456-7890')
  expect(lead.marketing_channel).to eq('Radio')
  expect(lead.note).to eq('Some note')
end

Then (/^case should be created$/) do
  expect(Case.where(name: 'Case')).to exist
  one_case = Case.last
  expect(one_case.name).to eq('Case')
  expect(one_case.state).to eq('AL')
  expect(one_case.case_type).to eq('Personal Injury')
  expect(one_case.subtype).to eq('Motor Vehicle')
  expect(one_case.topic).to eq('Case topic')
  expect(one_case.description).to eq('Case summary')
  expect(one_case.contacts.last.first_name).to eq('Artem')
  expect(one_case.contacts.last.last_name).to eq('Suchov')
  # expect(one_case.incident.incident_date.strftime('%F')).to eq('2014-12-12')
  # expect(one_case.medical.total_med_bills).to eq('5000'.to_f)
  # expect(one_case.medical.injuries.last.injury_type).to eq('TBI')
  # expect(one_case.medical.injuries.last.region).to eq('Skull')
end

Then (/^task list with task_draft should be created$/) do
  step 'task list with task_draft should be created by user with email "artem.suchov@gmail.com"'
end

Then (/^task list with task_draft should be created by user with email "(.*?)"$/) do |email|
  user = User.find_by(email: email)
  firm = user.firm

  expect(TaskList.where(name: 'Test Task List')).to exist
  task_list = TaskList.last
  expect(task_list.name).to eq('Test Task List')
  expect(task_list.view_permission).to eq('author')
  expect(task_list.amend_permission).to eq('author')
  expect(task_list.user_id).to eq(user.id)
  expect(task_list.firm_id).to eq(firm.id)
  expect(task_list.task_import).to eq('automatic')
  expect(task_list.case_type).to eq('Personal Injury')
  expect(task_list.case_creator).to eq('owner')

  task_draft_1 = task_list.task_drafts.first
  expect(task_draft_1.name).to eq('Parent task')
  expect(task_draft_1.description).to eq('Parent task description')
  expect(task_draft_1.due_term).to eq(3)
  expect(task_draft_1.conjunction).to eq('After')
  expect(task_draft_1.anchor_date).to eq('affair.created_at')

  task_draft_2 = task_list.task_drafts.last
  expect(task_draft_2.name).to eq('Parent task 2')
  expect(task_draft_2.description).to eq('Parent task 2 description')
  expect(task_draft_2.due_term).to eq(23)
  expect(task_draft_2.conjunction).to eq('After')
  expect(task_draft_2.anchor_date).to eq('affair.created_at')
end

Then (/^task list with manual and task_draft should be created by user with email "(.*?)"$/) do |email|
  user = User.find_by(email: email)
  firm = user.firm

  expect(TaskList.where(name: 'Test Task List')).to exist
  task_list = TaskList.last
  expect(task_list.name).to eq('Test Task List')
  expect(task_list.view_permission).to eq('all_firm')
  expect(task_list.amend_permission).to eq('all_firm')
  expect(task_list.user_id).to eq(user.id)
  expect(task_list.firm_id).to eq(firm.id)
  expect(task_list.task_import).to eq('manual')

  expect(task_list.task_drafts.size).to eq(2)

  task_draft_1 = task_list.task_drafts.first
  expect(task_draft_1.name).to eq('Parent task')
  expect(task_draft_1.description).to eq('Parent task description')
  expect(task_draft_1.due_term).to eq(3)
  expect(task_draft_1.conjunction).to eq('After')
  expect(task_draft_1.anchor_date).to eq('affair.created_at')

  expect(task_draft_1.children.size).to eq(2)
  task_1 = task_draft_1.children.first
  expect(task_1.name).to eq('Child task 1')
  expect(task_1.description).to eq('Child task description')
  expect(task_1.due_term).to eq(1)
  expect(task_1.conjunction).to eq('After')
  expect(task_1.anchor_date).to eq('parent')

  task_2 = task_draft_1.children.last
  expect(task_2.name).to eq('Child task 2')
  expect(task_2.description).to eq('Child task description 2')
  expect(task_2.due_term).to eq(2)
  expect(task_2.conjunction).to eq('After')
  expect(task_2.anchor_date).to eq('parent')

  task_draft_2 = task_list.task_drafts.last
  expect(task_draft_2.name).to eq('Parent task 2')
  expect(task_draft_2.description).to eq('Parent task 2 description')
  expect(task_draft_2.due_term).to eq(23)
  expect(task_draft_2.conjunction).to eq('After')
  expect(task_draft_2.anchor_date).to eq('affair.created_at')
end

Then(/^task list with dependent task_draft should be created$/) do
  step 'task list with dependent task_draft should be created by user with email "artem.suchov@gmail.com"'
end

Then(/^task list with dependent task_draft should be imported$/) do
  step 'task list with dependent task_draft should be imported by user with email "artem.suchov@gmail.com"'
end

Then(/^task list without dependent task_draft should be imported$/) do
  step 'task list without dependent task_draft should be imported by user with email "artem.suchov@gmail.com"'
end

Then(/^task list with manual and task_draft should be created$/) do
  step 'task list with manual and task_draft should be created by user with email "artem.suchov@gmail.com"'
end

Then(/^task list should contain tasks from couple lists$/) do
  step 'task list should contain tasks from couple lists by user with email "artem.suchov@gmail.com"'
end

Then (/^task list with dependent task_draft should be created by user with email "(.*?)"$/) do |email|
  user = User.find_by email: email
  firm = user.firm
  expect(TaskList.where(name: 'Test Task List')).to exist
  task_list = TaskList.last
  task_draft = task_list.task_drafts.first
  dependent_task_draft = task_draft.children.last
  expect(task_list.name).to eq('Test Task List')
  expect(task_list.view_permission).to eq('author')
  expect(task_list.amend_permission).to eq('author')
  expect(task_list.user_id).to eq(user.id)
  expect(task_list.firm_id).to eq(firm.id)

  expect(task_draft.name).to eq('Parent task')
  expect(task_draft.due_term).to eq(3)
  expect(task_draft.conjunction).to eq('After')
  expect(task_draft.anchor_date).to eq('affair.created_at')
  expect(task_draft.description).to eq('Parent task description')

  expect(dependent_task_draft.name).to eq('Dependent task')
  expect(dependent_task_draft.due_term).to eq(2)
  expect(dependent_task_draft.conjunction).to eq('After')
  expect(dependent_task_draft.anchor_date).to eq('parent')
  expect(dependent_task_draft.description).to eq('Dependent task description')
end

Then(/^task list with dependent task_draft should be imported by user with email "(.*?)"$/) do |email|
  user = User.find_by email: email
  last_case = user.firm.cases.last
  expect(last_case.tasks.size).to eq(3)

  task_1 = last_case.tasks.first
  expect(task_1.name).to eq('Parent task')
  expect(task_1.due_term).to eq(3)
  expect(task_1.conjunction).to eq('After')
  expect(task_1.anchor_date).to eq('affair.created_at')
  expect(task_1.description).to eq('Parent task description')

  task_2 = last_case.tasks[1]
  expect(task_2.name).to eq('Dependent task')
  expect(task_2.due_term).to eq(2)
  expect(task_2.conjunction).to eq('After')
  expect(task_2.anchor_date).to eq('parent')
  expect(task_2.description).to eq('Dependent task description')

  task_3 = last_case.tasks[2]
  expect(task_3.name).to eq('Parent task 2')
  expect(task_3.due_term).to eq(23)
  expect(task_3.conjunction).to eq('After')
  expect(task_3.anchor_date).to eq('affair.created_at')
  expect(task_3.description).to eq('Parent task 2 description')
end

Then(/^task list without dependent task_draft should be imported by user with email "(.*?)"$/) do |email|
  user = User.find_by email: email
  last_case = user.firm.cases.last
  expect(last_case.tasks.size).to eq(2)

  task_first = last_case.tasks.first
  expect(task_first.name).to eq('Parent task')
  expect(task_first.due_term).to eq(3)
  expect(task_first.conjunction).to eq('After')
  expect(task_first.anchor_date).to eq('affair.created_at')
  expect(task_first.description).to eq('Parent task description')

  task_last = last_case.tasks.last
  expect(task_last.name).to eq('Parent task 2')
  expect(task_last.due_term).to eq(23)
  expect(task_last.conjunction).to eq('After')
  expect(task_last.anchor_date).to eq('affair.created_at')
  expect(task_last.description).to eq('Parent task 2 description')
end

Then(/^task list should contain tasks from couple lists by user with email "(.*?)"$/) do |email|
  user = User.find_by email: email
  last_case = user.firm.cases.last
  expect(last_case.tasks.size).to eq(5)

  task_1 = last_case.tasks.first
  expect(task_1.name).to eq('Parent task')
  expect(task_1.due_term).to eq(3)
  expect(task_1.conjunction).to eq('After')
  expect(task_1.anchor_date).to eq('affair.created_at')
  expect(task_1.description).to eq('Parent task description')

  task_2 = last_case.tasks[1]
  expect(task_2.name).to eq('Dependent task')
  expect(task_2.due_term).to eq(2)
  expect(task_2.conjunction).to eq('After')
  expect(task_2.anchor_date).to eq('parent')
  expect(task_2.description).to eq('Dependent task description')

  task_3 = last_case.tasks[2]
  expect(task_3.name).to eq('Parent task 2')
  expect(task_3.due_term).to eq(23)
  expect(task_3.conjunction).to eq('After')
  expect(task_3.anchor_date).to eq('affair.created_at')
  expect(task_3.description).to eq('Parent task 2 description')

  task_4 = last_case.tasks[3]
  expect(task_4.name).to eq('Parent task')
  expect(task_4.due_term).to eq(3)
  expect(task_4.conjunction).to eq('After')
  expect(task_4.anchor_date).to eq('affair.created_at')
  expect(task_4.description).to eq('Parent task description')

  task_5 = last_case.tasks[4]
  expect(task_5.name).to eq('Parent task 2')
  expect(task_5.due_term).to eq(23)
  expect(task_5.conjunction).to eq('After')
  expect(task_5.anchor_date).to eq('affair.created_at')
  expect(task_5.description).to eq('Parent task 2 description')
end