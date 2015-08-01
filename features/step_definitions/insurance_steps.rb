When(/^I add insurance row with type: "(.*?)", holder: "(.*?)", claim_number: "(.*?)", policy_limit: "(.*?)"$/) do |insurance_type, policy_holder, claim_number, policy_limit|
  click_on 'ADD INSURANCE'
  page.execute_script(%($('#children>tr.insurance-field:last').find("input[name*='[insurance_type]']").val('#{insurance_type}')))
  page.execute_script(%($('#children>tr.insurance-field:last').find("input[name*='[policy_holder]']").val('#{policy_holder}')))
  page.execute_script(%($('#children>tr.insurance-field:last').find("input[name*='[claim_number]']").val('#{claim_number}')))
  page.execute_script(%($('#children>tr.insurance-field:last').find("input[name*='[policy_limit]']").val('#{policy_limit}')))
end

When /^I change insurance row "(.*?)" field "(.*?)" with "(.*?)"$/ do |index, field, value|
  page.execute_script(%($($('#children>tr.insurance-field')[#{(index.to_i-1).to_s}]).find("input[name*='[#{field}]']").val('#{value}')))
  sleep 0.1
end

When /^I remove insurance row "(\d+)"$/ do |index|
  page.execute_script(%($($('#children>tr.insurance-field')[#{(index.to_i-1).to_s}]).find(".remove_children > span").click()))
end

Then /^I verify case insurances count "(\d+)"$/ do |count|
  _case = Case.last
  expect(_case.insurance.children.count).to eq count.to_i
end

Then /^I verify saved case insurances with index "(.*?)" and fields "(.*?)", "(.*?)", "(.*?)", "(.*?)"$/ do |index, insurance_type, policy_holder, claim_number, policy_limit|
  _case = Case.last
  children = _case.insurance.children[index.to_i] rescue nil
  expect(children).to_not be_nil
  expect(children.insurance_type.to_s).to eq insurance_type
  expect(children.policy_holder.to_s).to eq policy_holder
  expect(children.claim_number.to_s).to eq claim_number
  expect(children.policy_limit.to_f).to eq policy_limit.to_f
end

Then /^I case insurances total should be "(.*?)"$/ do |sum|
  _case = Case.last
  expect(Insurance::total_policy_limit_amount(_case).to_f).to eq sum.to_f
end