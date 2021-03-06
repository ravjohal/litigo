Then(/^I create a case step by step$/) do
  step 'I go to cases'
  step 'I create a case'
end

Then(/^I create a medical case step by step$/) do
  step 'I go to cases'
  step 'I create a medical case'
end

Then(/^I create a case step by step detailed$/) do
  step 'I go to cases'
  step 'I create a case detailed'
end

When /^I go to cases$/ do
  # step 'I open case management menu'
  click_on 'Cases'
  sleep 0.3
end

When(/^I create a medical case$/) do
  visit '/cases'
  click_on 'NEW CASE'
  sleep 0.5
  fill_in 'case_name', with: 'some medical case'
  step 'I select first item from "case_state"'
  select 'Personal Injury', :from => 'case_case_type'
  select 'Insurance Bad Faith', :from => 'case_subtype'
  fill_in 'case_topic', with: 'Case Medical Topic'
  fill_in 'case_description', with: 'Case Medical Summary'
  click_on 'Create Case'
  expect(page).to have_content('Case was successfully created.')
end

When(/^I create a case$/) do
  visit '/cases'
  click_on 'NEW CASE'
  sleep 0.5
  fill_in 'case_name', with: 'some case'
  select 'Bankruptcy', :from => 'case_case_type'
  click_on 'Create Case'
  expect(page).to have_content('Case was successfully created.')
end

When(/^I create a second case$/) do
  visit '/cases'
  click_on 'NEW CASE'
  sleep 0.5
  fill_in 'case_name', with: 'some case 2'
  select 'Bankruptcy', :from => 'case_case_type'
  click_on 'Create Case'
  expect(page).to have_content('Case was successfully created.')
end

When(/^I create a case detailed$/) do
  visit '/cases'
  click_on 'NEW CASE'
  sleep 0.5
  fill_in 'case_name', with: 'some case'
  fill_in 'case_topic', with: 'Case Topic'
  fill_in 'case_description', with: 'Case Summary'

  select 'Bankruptcy', :from => 'case_case_type'

  step 'I select "Artem Suchov" from "case_attorney"'
  step 'I select "Artem Suchov" from "case_staff"'
  step 'I select first item from "case_state"'
  step 'I select first item from "case_subtype"'

  click_on 'Create Case'
end

When /^I fill case details form$/ do
  fill_in 'case_name', with: 'NewCaseName'
  fill_in 'case_docket_number', with: '12345'
  fill_in 'case_court', with: '12345789'
  fill_in 'case_county', with: '123123'
  select 'Arizona', from: 'case_state'
  fill_in 'case_statute_of_limitations', with: '12.12.2015'
  fill_in 'case_hearing_date', with: '12.12.2015'
  fill_in 'case_filed_suit_date', with: '12.12.2015'
  fill_in 'case_trial_date', with: '12.12.2015'
  select 'Litigation', from: 'case_status'
  fill_in 'case_topic', with: 'NewCaseTopic'
  fill_in 'case_description', with: 'NewCaseSummary'
  select 'Intentional Tort', from: 'case_subtype'
end

Then(/^I verify required fields for case for user with email "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  _case = u.cases.last
  expect(_case.name).to eq 'some case'
  expect(_case.case_number).to eq 1
end

Then(/^I verify required fields for second case for user with email "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  _case = u.cases.last
  _first_case = u.cases.first
  expect(_case.name).to eq 'some case 2'
  expect(_case.case_number).to eq(_first_case.case_number+1)
end

Then(/^I verify required fields for detailed case for user with email "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  _case = u.cases.last
  expect(_case.name).to eq 'some case'
  expect(_case.case_number).to eq 1
  expect(_case.case_contacts.joins(:contact).where(case_id: _case.id, firm_id: _case.firm_id, role: 'Attorney', :contacts => {:email => arg1}).size).to eq(1)
  expect(_case.case_contacts.joins(:contact).where(case_id: _case.id, firm_id: _case.firm_id, role: 'Staff', :contacts => {:email => arg1}).size).to eq(1)
end

Then(/^I change the case fields$/) do
  click_on 'Edit'
  sleep 0.5
  fill_in 'case_name', with: 'some other case'
  fill_in 'case_docket_number', with: '11'
  click_on 'Save'
end

Then(/^I verify required fields for case for user with email "(.*?)" are changed$/) do |arg1|
  u = User.where(email: arg1).last
  _case = Case.where(id: u.id).last
  expect(_case.name).to eq 'some other case'
  expect(_case.docket_number).to eq '11'
  expect(_case.case_number).to eq 1
end

Then(/^all tabs are created$/) do
  click_on 'Resolution'
  expect(page).to have_content('Resolution Amount:')
  click_on 'Details'
  expect(page).to have_content('Case Administration')
  click_on 'Documents'
  expect(page).to have_content('NEW DOCUMENT')
  click_on 'Notes'
  expect(page).to have_content('NEW NOTE')
  click_on 'Contacts'
  expect(page).to have_content('NEW CONTACT')
  click_on 'Tasks'
  expect(page).to have_content('My Tasks')
end

Then(/^all tabs are created includint medical$/) do
  click_on 'Resolution'
  expect(page).to have_content('Resolution Amount:')
  click_on 'Medicals'
  expect(page).to have_content('Medical Bills')
  click_on 'Incident'
  expect(page).to have_content('Incident Summary')
  click_on 'Insurance'
  expect(page).to have_content('Insurance Summary')
  click_on 'Details'
  expect(page).to have_content('Case Administration')
  click_on 'Documents'
  expect(page).to have_content('NEW DOCUMENT')
  click_on 'Notes'
  expect(page).to have_content('NEW NOTE')
  click_on 'Contacts'
  expect(page).to have_content('NEW CONTACT')
  click_on 'Tasks'
  expect(page).to have_content('My Tasks')
end

Given(/^Default case exist$/) do
  step 'Default case exist for user: "artem.suchov@gmail.com"'
end
Given(/^Default case exist with name "(.*?)"$/) do |name|
  step "Default case exist for user \"artem.suchov@gmail.com\" with name \"#{name}\""
end

Given(/^Default case exist with type "(.*?)"$/) do |type|
  user = User.find_by :email => 'artem.suchov@gmail.com'
  firm = user.firm
  _case = FactoryGirl.create(:case, user: user, firm: firm, case_type: type)
  CaseContact.create(case_id: _case.id, contact_id: user.contact_user.try(:id), firm_id: firm.id, role: 'Attorney')
end

Given(/^Default case exist with type and name "(.*?)"$/) do |type|
  user = User.find_by :email => 'artem.suchov@gmail.com'
  firm = user.firm
  _case = FactoryGirl.create(:case, user: user, firm: firm, subtype: type, name: type, :case_type => type)
  CaseContact.create(case_id: _case.id, contact_id: user.contact_user.try(:id), firm_id: firm.id, role: 'Attorney')
end

Given(/^Default case exist with summary and name "(.*?)"$/) do |type|
  user = User.find_by :email => 'artem.suchov@gmail.com'
  firm = user.firm
  _case = FactoryGirl.create(:case, user: user, firm: firm, description: type, name: type)
  CaseContact.create(case_id: _case.id, contact_id: user.contact_user.try(:id), firm_id: firm.id, role: 'Attorney')
end
Given(/^Default case exist with status and name "(.*?)"$/) do |type|
  user = User.find_by :email => 'artem.suchov@gmail.com'
  firm = user.firm
  _case = FactoryGirl.create(:case, user: user, firm: firm, status: type, name: type)
  CaseContact.create(case_id: _case.id, contact_id: user.contact_user.try(:id), firm_id: firm.id, role: 'Attorney')
end

Given(/^Default medical case exist$/) do
  step 'Default medical case exist for user: "artem.suchov@gmail.com"'
end

Given(/^Default case exist for user: "(.*?)"$/) do |email|
  user = User.find_by :email => email
  firm = user.firm
  _case = FactoryGirl.create(:case, user: user, firm: firm)
  CaseContact.create(case_id: _case.id, contact_id: user.contact_user.try(:id), firm_id: firm.id, role: 'Attorney')
end

Given(/^Default case exist for user "(.*?)" with name "(.*?)"$/) do |email, name|
  user = User.find_by :email => email
  firm = user.firm
  _case = FactoryGirl.create(:case, user: user, firm: firm, name: name)
  CaseContact.create(case_id: _case.id, contact_id: user.contact_user.try(:id), firm_id: firm.id, role: 'Attorney')
end

Given(/^Default medical case exist for user: "(.*?)"$/) do |email|
  user = User.find_by :email => email
  firm = user.firm
  _case = FactoryGirl.create(:medical_case, user: user, firm: firm)
  CaseContact.create(case_id: _case.id, contact_id: user.contact_user.try(:id), firm_id: firm.id, role: 'Attorney')
end

When(/^I go to first case$/) do
  step 'I click "Cases"'
  step 'I click to element with selector "#user_cases tr > td > a"'
end

When(/^I go to first firm case$/) do
  step 'I click "Cases"'
  sleep 10
  step 'I click to element with selector "#cases tr > td > a"'
end

When /^I fill case search field "(.*?)" with "(.*?)"$/ do |id, value|
  step "I fill field with selector \"##{id}_filter input\" with \"#{value}\""
  step "I fill field with selector \"##{id}_filter input\" with \"#{value}\""
  sleep 0.2
  step "I fill field with selector \"##{id}_filter input\" with \"#{value}\""
  step "I fill field with selector \"##{id}_filter input\" with \"#{value}\""
  sleep 0.2
end

Then(/^I verify assigned contact "(.*?)" for user "(.*?)"$/) do |contact_type, email|
  _case = Case.last
  expect(_case.case_contacts.joins(:contact).where(case_id: _case.id, firm_id: _case.firm_id, role: contact_type, :contacts => {:email => email}).size).to eq(1)
end
Then(/^I verify assigned contact by type "(.*?)" for user with first name "(.*?)" and last name "(.*?)"$/) do |contact_type, first_name, last_name|
  _case = Case.last
  expect(_case.case_contacts.joins(:contact).where(case_id: _case.id, firm_id: _case.firm_id, role: contact_type, :contacts => {:first_name => first_name, :last_name => last_name}).size).to eq(1)
end

Then /^I verify case details tab$/ do
  user = User.last
  sleep 10
  step 'I should have text "case_name"'
  step 'I should have text "AL"'
  step 'I should have text "Case Topic"'
  step 'I should have text "Case Summary"'
  step "I should have text \"#{simple_format_date(Time.now.in_time_zone(user.time_zone))}\""
end

Then /^I verify case details updated for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  _case = user.cases.first
  expect(_case.name).to eq 'NewCaseName'
  expect(_case.docket_number.to_s).to eq '12345'
  expect(_case.court.to_s).to eq '12345789'
  expect(_case.county.to_s).to eq '123123'
  expect(_case.state.to_s).to eq 'AZ'
  expect(_case.statute_of_limitations.to_s).to eq '2015-12-12'
  expect(_case.hearing_date.to_s).to eq '2015-12-12'
  expect(_case.filed_suit_date.to_s).to eq '2015-12-12'
  expect(_case.status.to_s).to eq 'Litigation'
  expect(_case.topic.to_s).to eq 'NewCaseTopic'
  expect(_case.description.to_s).to eq 'NewCaseSummary'
  expect(_case.subtype.to_s).to eq 'Intentional Tort'
end

Then /^I verity deleted case for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  expect(user.cases.size).to eq 0
end

Then /^I verify sorted firm cases on descending \#$/ do
  step 'I verify sorted rows in table "cases" in column "1" by values "3,2,1"'
end

Then /^I verify sorted own cases on descending \#$/ do
  step 'I verify sorted rows in table "user_cases" in column "1" by values "3,2,1"'
end

Then /^I verify sorted cases alphabetically in descending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"2\" by values \"Cde,Bcd,Abc\""
end

Then /^I verify sorted cases alphabetically in ascending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"2\" by values \"Abc,Bcd,Cde\""
end

Then /^I verify sorted cases alphabetically type in ascending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"3\" by values \"Abc,Bcd,Cde\""
end

Then /^I verify sorted cases alphabetically type in descending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"3\" by values \"Cde,Bcd,Abc\""
end

Then /^I verify sorted cases alphabetically summary in ascending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"4\" by values \"Abc,Bcd,Cde\""
end

Then /^I verify sorted cases alphabetically summary in descending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"4\" by values \"Cde,Bcd,Abc\""
end

Then /^I verify sorted cases alphabetically status in ascending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"5\" by values \"Abc,Bcd,Cde\""
end

Then /^I verify sorted cases alphabetically status in descending for "(.*?)"$/ do |table|
  step "I verify sorted rows in table \"#{table}\" in column \"5\" by values \"Cde,Bcd,Abc\""
end

Then /^I should have cases "(.*?)" in table "(.*?)"$/ do |case_nums, table|
  step "I verify sorted rows in table \"#{table}\" in column \"1\" by values \"#{case_nums}\""
end