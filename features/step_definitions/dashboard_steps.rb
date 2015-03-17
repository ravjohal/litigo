Then (/^I see dashboard with creation quick-links$/) do
  expect(page).to have_content('New Client Intake')
  expect(page).to have_content('New Case')
  expect(page).to have_content('New Contact')
  expect(page).to have_content('New Task')
  expect(page).to have_content('New Document')
  expect(page).to have_content('New Note')
end

When (/^I click "(.*?)"$/) do |arg|
  click_on arg
end

Then (/^I return to dashboard$/) do
  visit '/'
end

When (/^I fill Client Intake modal$/) do
  fill_in 'lead_first_name', with: 'First'
  fill_in 'lead_last_name', with: 'Last'
  page.execute_script(%Q{ $('input#lead_phone').val('(123) 456-7890'); })
  first('.select2-default').click
  find(".select2-result-label", text: 'Radio').click
  fill_in 'lead_note', with: 'Some note'
  click_on 'Create Lead'
end

When (/^I fill Case modal$/) do
  fill_in 'case_name', with: 'Case'
  first('.controls').click
  # select Attorney
  within ".case_contacts" do
    first('.select2-choices').click
  end
  find(".select2-result-label", text: 'Andrew Goncharenko').click
  ####
  fill_in 'case_county', with: 'County'
  # select State
  within ('#s2id_case_state') do
    first('.select2-default').click
  end
  find(".select2-result-label", text: 'Alabama').click
  ####
  # select Case Type
  within ('#s2id_case_case_type') do
    first('.select2-chosen').click
  end
  find(".select2-result-label", text: 'Personal Injury').click
  ####
  # select Case sub-type
  within ('#s2id_case_subtype') do
    first('.select2-chosen').click
  end
  find(".select2-result-label", text: 'Negligence').click
  ####
  # set Incident date
  page.execute_script("$('#case_incident_attributes_incident_date').val('12.12.2014')")
  ####
  fill_in 'case_medical_attributes_total_med_bills', with: '5000'
  # select Primary Injury
  within ('#s2id_case_medical_attributes_injuries_attributes_0_injury_type') do
    first('.select2-default').click
  end
  find(".select2-result-label", text: 'TBI').click
  ####
  # select Primary Injury Region
  within ('#s2id_case_medical_attributes_injuries_attributes_0_region') do
    first('.select2-default').click
  end
  find(".select2-result-label", text: 'Skull').click
  ####
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
  expect(Case.where(name: 'Case', county: 'County')).to exist
  one_case = Case.last
  expect(one_case.name).to eq('Case')
  expect(one_case.county).to eq('County')
  expect(one_case.state).to eq('AL')
  expect(one_case.case_type).to eq('Personal Injury')
  expect(one_case.subtype).to eq('Negligence')
  expect(one_case.description).to eq('Case summary')
  expect(one_case.contacts.last.first_name).to eq('Andrew')
  expect(one_case.contacts.last.last_name).to eq('Goncharenko')
  expect(one_case.incident.incident_date.strftime('%F')).to eq('2014-12-12')
  expect(one_case.medical.total_med_bills).to eq('5000'.to_f)
  expect(one_case.medical.injuries.last.injury_type).to eq('TBI')
  expect(one_case.medical.injuries.last.region).to eq('Skull')
end

Then (/^task list with task_draft should be created$/) do
  user = User.find_by(email: 'andrew@rubyriders.com')
  firm = user.firm
  expect(TaskList.where(name: 'Test Task List')).to exist
  task_list = TaskList.last
  task_draft = task_list.task_drafts.last
  expect(task_list.name).to eq('Test Task List')
  expect(task_list.view_permission).to eq('author')
  expect(task_list.amend_permission).to eq('author')
  expect(task_list.user_id).to eq(user.id)
  expect(task_list.firm_id).to eq(firm.id)
  expect(task_draft.name).to eq('Parent task')
  expect(task_draft.due_term).to eq(3)
  expect(task_draft.due_term).to eq(3)
  expect(task_draft.conjunction).to eq('before')
  expect(task_draft.anchor_date).to eq('close date')
  expect(task_draft.description).to eq('Parent task description')
end

Then (/^task list with dependent task_draft should be created$/) do
  user = User.find_by(email: 'andrew@rubyriders.com')
  firm = user.firm
  expect(TaskList.where(name: 'Test Task List')).to exist
  task_list = TaskList.last
  task_draft = task_list.task_drafts.last
  dependent_task_draft = task_draft.children.last
  expect(task_list.name).to eq('Test Task List')
  expect(task_list.view_permission).to eq('author')
  expect(task_list.amend_permission).to eq('author')
  expect(task_list.user_id).to eq(user.id)
  expect(task_list.firm_id).to eq(firm.id)
  expect(task_draft.name).to eq('Parent task')
  expect(task_draft.due_term).to eq(3)
  expect(task_draft.conjunction).to eq('before')
  expect(task_draft.anchor_date).to eq('close date')
  expect(task_draft.description).to eq('Parent task description')
  expect(dependent_task_draft.name).to eq('Dependent task')
  expect(dependent_task_draft.due_term).to eq(2)
  expect(dependent_task_draft.conjunction).to eq('after')
  expect(dependent_task_draft.anchor_date).to eq('previous task')
  expect(dependent_task_draft.description).to eq('Dependent task description')
end
