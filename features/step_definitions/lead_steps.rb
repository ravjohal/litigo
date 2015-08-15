Given /^Default lead for default user$/ do
  step 'Default lead for user "artem.suchov@gmail.com"'
end

Given /^Default lead for user "(.*?)"$/ do |email|
  step "Exist lead for user \"#{email}\""
end

Given /^Exist simple lead for user "(.*?)"$/ do |email|
  user = User.find_by email: email
  firm = user.firm
  FactoryGirl.create(:lead, attorney: user, screener: user, firm: firm)
end

Given /^Exist lead in date "(.*?)" for user "(.*?)"$/ do |date, email|
  user = User.find_by email: email
  firm = user.firm
  FactoryGirl.create(:lead, attorney: user, screener: user, firm: firm, created_at: convert_date_by_user_timezone(date, user))
end

Given /^Exist advanced lead for user "(.*?)" with name "(.*?)" and "(.*?)" and date "(.*?)" and estimated "(\d+)" and status "(.*?)"$/ do |email, first_name, last_name, date, estimated_value, status|
  user = User.find_by email: email
  firm = user.firm
  FactoryGirl.create(:lead, attorney: user, screener: user, firm: firm, first_name: first_name, last_name: last_name, created_at: convert_date_by_user_timezone(date, user), estimated_value: estimated_value, status: status)
end

Given /^Exist lead for attorney "(.*?)" and user "(.*?)" and date "(.*?)"$/ do |email_attorney, email, date|
  user = User.find_by email: email
  firm = user.firm

  attorney = User.find_by email: email_attorney
  FactoryGirl.create(:lead, attorney: attorney, screener: user, firm: firm, created_at: convert_date_by_user_timezone(date, user))
end

Given /^Exist difficult lead for user "(.*?)" for attorney "(.*?)" with name "(.*?)" and "(.*?)" and date "(.*?)" and estimated "(\d+)" and status "(.*?)"$/ do |email, email_attorney, first_name, last_name, date, estimated_value, status|
  user = User.find_by email: email
  firm = user.firm

  attorney = User.find_by email: email_attorney
  FactoryGirl.create(:lead, attorney: attorney, screener: user, firm: firm, first_name: first_name, last_name: last_name, created_at: convert_date_by_user_timezone(date, user), estimated_value: estimated_value, status: status)
end

When(/^I create a lead$/) do
  step 'I create a lead with name "Leeds" and last name "United"'
end

When(/^I create a medical lead$/) do
  click_on 'NEW CALLER INTAKE'
  sleep 0.5
  fill_in 'lead_first_name', with: 'TestFirstName'
  fill_in 'lead_last_name', with: 'TestLastName'
  fill_in 'lead_phone', with: '(999) 999-9999'
  fill_in 'lead_address', with: 'TestAddress'
  fill_in 'lead_city', with: 'TestCity'
  select 'Alabama', from: 'lead_state'
  fill_in 'lead_zip_code', with: '123456'
  select 'Google', from: 'lead_marketing_channel'
  fill_in 'lead_note', with: 'TestNote'
  click_on 'Create Lead'
end

When(/^I create a ohio medical lead$/) do
  click_on 'NEW CALLER INTAKE'
  sleep 0.5
  fill_in 'lead_first_name', with: 'TestFirstName'
  fill_in 'lead_last_name', with: 'TestLastName'
  fill_in 'lead_phone', with: '(999) 999-9999'
  fill_in 'lead_address', with: 'TestAddress'
  fill_in 'lead_city', with: 'TestCity'
  select 'Ohio', from: 'lead_state'
  fill_in 'lead_zip_code', with: '123456'
  select 'Google', from: 'lead_marketing_channel'
  fill_in 'lead_note', with: 'TestNote'
  click_on 'Create Lead'
end

When /^I edit a medical lead$/ do
  click_on 'Edit'
  sleep 0.5
  select 'Personal Injury', from: 'lead_case_type'
  select 'Insurance Bad Faith', from: 'lead_sub_type'
  fill_in 'lead_estimated_value', with: 10000
  fill_in 'lead_lead_policy_limit', with: 1000
  select 'Truama', from: 'lead_primary_injury'
  select 'Head', from: 'lead_primary_region'
  fill_in 'lead_incident_date', with: '12.12.2014'
  end

When /^I edit a motor vehicle medical lead$/ do
  click_on 'Edit'
  sleep 0.5
  select 'Personal Injury', from: 'lead_case_type'
  select 'Motor Vehicle', from: 'lead_sub_type'
  fill_in 'lead_estimated_value', with: 10000
  fill_in 'lead_lead_policy_limit', with: 1000
  select 'Truama', from: 'lead_primary_injury'
  select 'Head', from: 'lead_primary_region'
  fill_in 'lead_incident_date', with: '12.12.2014'
end

When(/^I create a lead with name "(.*?)" and last name "(.*?)"$/) do |first_name, last_name|
  click_on 'NEW CALLER INTAKE'
  sleep 0.5
  fill_in 'lead_first_name', with: first_name
  fill_in 'lead_last_name', with: last_name
  click_on 'Create Lead'
end

When /^I fill lead copy case form$/ do
  fill_in 'case_name', with: 'NewLeadCaseCopy'
end

Then(/^I check message "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I verify lead has been created for user: "(.*?)"$/) do |arg1|
  step "I verify lead first name \"Leeds\" and last name \"United\" for user: \"#{arg1}\""
end

Then(/^I verify lead first name "(.*?)" and last name "(.*?)" for user: "(.*?)"$/) do |first_name, last_name, user|
  u = User.where(email: user).last
  lead = Lead.where(id: u.id).last
  expect(lead.first_name).to eq first_name
  expect(lead.last_name).to eq last_name
end

When(/^I edit lead$/) do
  click_on 'CONTACT'
  click_on 'Edit'
  sleep 0.5
  fill_in 'lead_first_name', with: 'Leeds 2'
  fill_in 'lead_last_name', with: 'United 2'
  click_on 'Save'
end

Then(/^I verify lead has been changed for user: "(.*?)"$/) do |arg1|
  u = User.where(email: arg1).last
  lead = Lead.where(id: u.id).last
  expect(lead.first_name).to eq 'Leeds 2'
  expect(lead.last_name).to  eq 'United 2'
end

When /^I add document for lead$/ do
  step 'I click to tab "Documents"'
  click_on 'NEW LEAD DOCUMENT'
  step 'I fill document popup'
end

When /^I edit lead contact$/ do
  click_on 'Edit'
  fill_in 'lead_first_name', with: 'NewLeadFirstName'
  fill_in 'lead_last_name', with: 'NewLeadLastName'
  choose 'lead_attorney_already_true'
  fill_in 'lead_attorney_name', with: 'NewAttorneyName'
  fill_in 'lead_dob', with: input_format_date(20.years.ago)
  fill_in 'lead_ssn', with: '12345'
  fill_in 'lead_phone', with: '(999) 999-9999'
  fill_in 'lead_email', with: 'somenew@email.com'
  fill_in 'lead_address', with: 'NewAddress'
  fill_in 'lead_city', with: 'NewCity'
  select 'Maryland', from: 'lead_state'
  fill_in 'lead_zip_code', with: '123456'
  click_on 'Save'
end

When /^I accept case$/ do
  step 'I click to element with id "accept"'
end

When(/^I delete lead$/) do
  find('#delete').click
  page.driver.browser.switch_to.alert.accept
end

When(/^I fill lead case fields$/) do
  select 'Personal Injury', :from => 'lead_case_type'
  select 'Wrongful Death', :from => 'lead_sub_type'
  select 'Open Wound', :from => 'lead_primary_injury'
  fill_in 'lead_estimated_value', with: '12345'
end

When /^I fill lead case with incident fields$/ do
  fill_in 'lead_incident_date', with: input_format_date(10.days.ago)
end

When(/^I check lead text field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  click_on 'Edit'
  sleep 0.5
  fill_in "lead_#{field}", with: text
  click_on 'Save'
  step "I verify lead field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check contact lead text field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  step 'I click on "CONTACT"'
  step "I check lead text field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check lead select field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  click_on 'Edit'
  sleep 0.5
  select text, :from => "lead_#{field}"
  click_on 'Save'
  step "I verify lead field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check contact lead select field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  step 'I click on "CONTACT"'
  step "I check lead select field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I check lead select with option value "(.*?)" for field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |validate_value, field, text, user|
  click_on 'Edit'
  sleep 0.5
  select text, :from => "lead_#{field}"
  click_on 'Save'
  step "I verify lead field \"#{field}\" by \"#{validate_value}\" for user: \"#{user}\""
end

When(/^I check contact lead select with option value "(.*?)" for field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |validate_value, field, text, user|
  step 'I click on "CONTACT"'
  step "I check lead select with option value \"#{validate_value}\" for field \"#{field}\" by \"#{text}\" for user: \"#{user}\""
end

When(/^I verify lead field "(.*?)" by "(.*?)" for user: "(.*?)"$/) do |field, text, user|
  u = User.where(email: user).last
  lead = Lead.where(id: u.id).last
  expect(lead.attributes[field].to_s).to eq(text.to_s)
end

Then(/^I verify lead case was created for user: "(.*?)"$/) do |user|
  u = User.where(email: user).last
  lead = Lead.where(id: u.id).last
  expect(lead.case).to_not be_nil
end

Then /^I verify accepted case with incident date for user: "(.*?)"$/ do |email|
  u = User.where(email: email).last
  lead = Lead.where(id: u.id).last
  _case = lead.case
  expect(_case).to_not be_nil
  expect(_case.incident).to_not be_nil
  expect(_case.incident.incident_date).to eq lead.incident_date
  expect(input_format_date(_case.incident.incident_date)).to eq input_format_date(10.days.ago)
end

Then /^I verify case date of intake$/ do
  user = User.last
  tr = parent_element page.find('td', :text => 'Date of Intake:')
  expect(tr).to have_content(simple_format_date(Time.now.in_time_zone(user.time_zone)))
end
Then /^I verify case type$/ do
  tr = parent_element page.find('td', :text => 'Type:')
  expect(tr).to have_content('Personal Injury')
end
Then /^I verify case sub type$/ do
  tr = parent_element page.find('td', :text => 'Subtype:')
  expect(tr).to have_content('Wrongful Death')
end
Then /^I verify case injury$/ do
  lead = Lead.last
  _case = Case.last
  expect(_case).to_not be_nil
  expect(_case.medical).to_not be_nil
  expect(_case.medical.injuries.size).to eq 1
  expect(_case.medical.injuries.first.injury_type).to eq lead.primary_injury
end
Then /^I verify case notes$/ do
  lead = Lead.last
  _case = Case.last
  expect(_case).to_not be_nil
  expect(_case.notes.size).to eq 1
  expect(_case.notes.first.note).to eq lead.note
end
Then /^I verify case resolution$/ do
  lead = Lead.last
  _case = Case.last
  expect(_case).to_not be_nil
  expect(_case.resolution).to_not be_nil
  expect(_case.resolution.estimated_value).to eq lead.estimated_value
end
Then /^I verify case summary$/ do
  lead = Lead.last
  _case = Case.last
  expect(_case).to_not be_nil
  expect(_case.description).to eq lead.case_summary
end
Then /^I verify case documents$/ do
  lead = Lead.last
  _case = Case.last
  expect(_case).to_not be_nil
  expect(_case.documents.size).to eq lead.documents.size
  expect(_case.documents.first.doc_type).to eq lead.documents.first.doc_type
  expect(_case.documents.first.document.instance_of?DocumentUploader).to be_truthy
  expect(_case.documents.first.document.to_s.split('/').last).to eq lead.documents.first.document.to_s.split('/').last
end

Then /^I verify lead document$/ do
  lead = Lead.last
  expect(lead.documents.size).to eq 1
  expect(lead.documents.first.doc_type).to eq 'text'
  expect(lead.documents.first.document.instance_of?DocumentUploader).to be_truthy
  expect(lead.documents.first.document.to_s.split('/').last).to eq 'document_ok.txt'
end

Then /^I verify lead contact has been changed$/ do
  lead = Lead.last
  expect(lead).to_not be_nil
  expect(lead.first_name).to eq 'NewLeadFirstName'
  expect(lead.last_name).to eq 'NewLeadLastName'
  expect(lead.attorney_name).to eq 'NewAttorneyName'
  expect(input_format_date(lead.dob)).to eq(input_format_date(20.years.ago))
  expect(lead.attorney_already).to be true
  expect(lead.ssn).to eq '12345'
  expect(lead.phone).to eq '(999) 999-9999'
  expect(lead.email).to eq 'somenew@email.com'
  expect(lead.address).to eq 'NewAddress'
  expect(lead.city).to eq 'NewCity'
  expect(lead.state).to eq 'MD'
  expect(lead.zip_code).to eq 123456
end