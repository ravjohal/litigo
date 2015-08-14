When /^I fill case medicals form$/ do
  choose 'medical_injuries_within_three_days_true'
  choose 'medical_hospitalization_true'
  fill_in 'medical_hospital_stay_length', with: 10
  select 'day(s)', from: 'medical_hospital_stay_length_unit'
  fill_in 'medical_earnings_lost', with: '1000'
  choose 'medical_injections_true'
  fill_in 'medical_length_of_treatment', with: 3
  check 'medical_doctor_type_md'
  check 'medical_doctor_type_do'
  check 'medical_treatment_type_pt'
  check 'medical_treatment_type_chiro'
  check 'medical_treatment_type_meds'
  choose 'medical_treatment_gap_true'
  fill_in 'medical_final_treatment_date', with: '12.12.2015'
  fill_in 'medical_injury_summary', with: 'Medical Summary'
end

When(/^I add bill row to medicals form with "(.*?)", "(.*?)", "(.*?)"$/) do |account_number, billed_amount, paid_amount|
  click_on 'ADD MEDICAL BILL'
  page.execute_script(%($('#medical_bills>tr.medical-bill-field:last').find("input[name*='[account_number]']").val('#{account_number}')))
  page.execute_script(%($('#medical_bills>tr.medical-bill-field:last').find("input[name*='[date_of_service]']").val('12.12.2015')))
  page.execute_script(%($('#medical_bills>tr.medical-bill-field:last').find("input[name*='[billed_amount]']").val('#{billed_amount}')))
  page.execute_script(%($('#medical_bills>tr.medical-bill-field:last').find("input[name*='[paid_amount]']").val('#{paid_amount}')))
end

When /^I fill injury form$/ do
  select 'Head', from: 'injury_region'
  select 'Soft Tissue Tear', from: 'injury_injury_type'
  fill_in 'injury_code', with: '123456'
  choose 'injury_dominant_side_true'
  choose 'injury_joint_fracture_true'
  choose 'injury_displaced_fracture_true'
  choose 'injury_disfigurement_true'
  choose 'injury_permanence_false'
  choose 'injury_disabled_false'
  fill_in 'injury_disabled_percent', with: 10
  choose 'injury_prior_complaint_true'
  choose 'injury_surgery_true'
  fill_in 'injury_surgery_count', with: '10'
  select 'Arthroscopic', from: 'injury_surgery_type'
  choose 'injury_casted_fracture_true'
  choose 'injury_stitches_false'
  choose 'injury_future_surgery_false'
  fill_in 'injury_future_medicals', with: '123456'
  choose 'injury_ongoing_pain_true'
end

When /^I update case medicals injury$/ do
  select 'Face', from: 'medical_injuries_attributes_0_region'
  select 'TBI', from: 'medical_injuries_attributes_0_injury_type'
  fill_in 'medical_injuries_attributes_0_code', with: '12345678'
  choose 'medical_injuries_attributes_0_dominant_side_false'
  choose 'medical_injuries_attributes_0_joint_fracture_false'
  choose 'medical_injuries_attributes_0_displaced_fracture_false'
  choose 'medical_injuries_attributes_0_disfigurement_false'
  choose 'medical_injuries_attributes_0_permanence_false'
  choose 'medical_injuries_attributes_0_disabled_true'
  fill_in 'medical_injuries_attributes_0_disabled_percent', with: 20
  choose 'medical_injuries_attributes_0_prior_complaint_false'
  choose 'medical_injuries_attributes_0_surgery_false'
  fill_in 'medical_injuries_attributes_0_surgery_count', with: '12'
  select 'Arthroscopic', from: 'medical_injuries_attributes_0_surgery_type'
  choose 'medical_injuries_attributes_0_casted_fracture_true'
  choose 'medical_injuries_attributes_0_stitches_false'
  choose 'medical_injuries_attributes_0_future_surgery_false'
  fill_in 'medical_injuries_attributes_0_future_medicals', with: '123456'
  choose 'medical_injuries_attributes_0_ongoing_pain_true'
end

Then(/^I create the medical$/) do
  click_on 'MEDICALS'
  sleep 0.3
  click_on 'Edit'
  sleep 0.3
  fill_in 'medical_total_med_bills', with: 2
  fill_in 'medical_subrogated_amount', with: 3
  click_on 'Save'
  expect(page).to have_content('Medical was successfully updated.')
end

Then(/^The medical for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).last
  expect(Medical.find_by_id(u.id).total_med_bills).to eq 2
  expect(Medical.find_by_id(u.id).subrogated_amount).to eq 3
end

Then(/^I create the injury$/) do
  click_on 'MEDICAL'
  click_on 'ADD INJURY'
  find("option[value='Strain/Sprain']").click
  find("option[value='Head']").click
  click_on 'Create Injury'
  expect(page).to have_content('Injury was successfully created.')
end

Then(/^The injury for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.find_by_email(arg1)
  m = Medical.find_by_id(u.id)
  expect(Injury.find_by_medical_id(m.id).region).to eq 'Head'
  expect(Injury.find_by_medical_id(m.id).injury_type).to eq 'Strain/Sprain'
end

Then /^case medical should be updated$/ do
  _case = Case.last
  medical = _case.medical
  expect(medical.injuries_within_three_days).to be true
  expect(medical.hospitalization).to be true
  expect(medical.hospital_stay_length.to_i).to eq 10
  expect(medical.hospital_stay_length_unit).to eq 'day(s)'
  expect(medical.earnings_lost.to_i).to eq 1000
  expect(medical.injections).to eq true
  expect(medical.length_of_treatment).to eq 3
  expect(medical.doctor_type.to_a.include?('MD')).to be true
  expect(medical.doctor_type.to_a.include?('DO')).to be true
  expect(medical.treatment_type.to_a.include?('PT')).to be true
  expect(medical.treatment_type.to_a.include?('Chiro')).to be true
  expect(medical.treatment_type.to_a.include?('Meds')).to be true
  expect(medical.treatment_gap).to be true
  expect(simple_input_format_date(medical.final_treatment_date)).to eq '2015-12-12'
  expect(medical.injury_summary).to eq 'Medical Summary'

  expect(medical.medical_bills.count).to eq 2
  expect(medical.total_billed.to_i).to eq 3500
  expect(medical.total_paid.to_i).to eq -420
  expect(medical.total_owed.to_i).to eq 3080
end

Then /^I verify medical injury count should be (\d+)$/ do |count|
  _case = Case.last
  medical = _case.medical
  expect(medical.injuries.count).to eq count.to_i
end

Then /^I verify created injury$/ do
  _case = Case.last
  medical = _case.medical

  last_injury = medical.injuries.last
  expect(last_injury.region).to eq 'Head'
  expect(last_injury.injury_type).to eq 'Soft Tissue Tear'
  expect(last_injury.code).to eq '123456'
  expect(last_injury.dominant_side).to be true
  expect(last_injury.joint_fracture).to be true
  expect(last_injury.disfigurement).to be true
  expect(last_injury.permanence).to be false
  expect(last_injury.disabled).to be false
  expect(last_injury.disabled_percent).to eq 10
  expect(last_injury.prior_complaint).to be true
  expect(last_injury.surgery).to be true
  expect(last_injury.surgery_count).to eq 10
  expect(last_injury.surgery_type).to eq 'Arthroscopic'
  expect(last_injury.casted_fracture).to be true
  expect(last_injury.stitches).to be false
  expect(last_injury.future_surgery).to be false
  expect(last_injury.ongoing_pain).to be true
  expect(last_injury.future_medicals.to_i).to eq 123456

end

Then /^I verify updated injury$/ do
  _case = Case.last
  medical = _case.medical

  last_injury = medical.injuries.last
  expect(last_injury.region).to eq 'Face'
  expect(last_injury.injury_type).to eq 'TBI'
  expect(last_injury.code).to eq '12345678'
  expect(last_injury.dominant_side).to be false
  expect(last_injury.joint_fracture).to be false
  expect(last_injury.disfigurement).to be false
  expect(last_injury.permanence).to be false
  expect(last_injury.disabled).to be true
  expect(last_injury.disabled_percent).to eq 20
  expect(last_injury.prior_complaint).to be false
  expect(last_injury.surgery).to be false
  expect(last_injury.surgery_count).to eq 12
  expect(last_injury.surgery_type).to eq 'Arthroscopic'
  expect(last_injury.casted_fracture).to be true
  expect(last_injury.stitches).to be false
  expect(last_injury.future_surgery).to be false
  expect(last_injury.ongoing_pain).to be true
  expect(last_injury.future_medicals.to_i).to eq 123456

end