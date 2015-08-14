
Then(/^select "(.*?)" should have "(\d+)" options?$/) do |select_id, count|
  number_of_columns = page.all(:xpath, "//select[@id='#{select_id}']//option").length
  expect(number_of_columns).to eq(count.to_i+1)
end

When(/^I select "(.*?)" from "(.*?)"$/) do |value, select_id|
  within "#s2id_#{select_id}" do
    first('.select2-choices').click
  end
  find('.select2-result-label', text: value).click
end

When(/^I select first item choices from "(.*?)"$/) do |select_id|
  within "#s2id_#{select_id}" do
    first('.select2-choices').click
  end
  first('.select2-result-label').click
end

When(/^I select first item from "(.*?)"$/) do |select_id|
  within "#s2id_#{select_id}" do
    first('.select2-default').click
  end
  first('.select2-result-label').click
end

When(/^I clear select "(.*?)"$/) do |select_id|
  within "#s2id_#{select_id}" do
    first('.select2-search-choice-close').click
  end
end

When (/^I click "(.*?)"$/) do |arg|
  click_on arg
end

When(/^I wait for "(.*?)" seconds$/) do |seconds|
  sleep seconds.to_f
end

Then(/^should exist tab "(.*?)"$/) do |tab|
  expect(find('#nav-tabs-custom')).to have_content(tab)
end

Then /^I should have text "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should have message "(.*?)"$/ do |text|
  expect(find('.alert')).to have_content(text)
end

When(/^I click on "(.*?)"$/) do |button|
  click_on button
end

When(/^I click on table header "(.*?)"$/) do |button|
  within 'table' do
    find('th', :text => button).click
  end
end

When(/^I click on table "(.*?)" header "(.*?)"$/) do |table_id, button|
  within "##{table_id}" do
    find('th', :text => button).click
  end
end

When(/^I click to tab "(.*?)"$/) do |tab|
  find('#nav-tabs-custom').click_on tab
end

When(/^I click to element with id "(.*?)"$/) do |id|
  find("##{id}").click
end

When(/^I click to element with selector "(.*?)"$/) do |id|
  find("#{id}").click
end

When /^I push delete button$/ do
  step 'I click to element with id "delete"'
  step 'I confirm popup'
end

When /^I open case management menu$/ do
  click_on 'Case Management'
end

When(/^I click to user dropdown$/) do
  page.execute_script(%($('#dropdownMenu1').click()))
end

Then /^I should see a JS alert$/ do
  expect(page.driver.browser.switch_to.alert).to_not be_nil
end

Then /^I should not see a JS alert$/ do
  alert = driver.switch_to.alert rescue 'exception happened'
  expect(alert).to eq('exception happened')
end

Then /^I should see a "(.*?)" JS alert dialog$/ do |text|
  expect(page.driver.browser.switch_to.alert.text).to eql(text)
end

When /^I should close alert$/ do
  page.driver.browser.switch_to.alert.accept
end

When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end

When /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end

When /^I fill field "(.*?)" with "(.*?)"$/ do |id, value|
  fill_in id, with: value
end

When /^I fill field with selector "(.*?)" with "(.*?)"$/ do |selector, value|
  page.execute_script(%($('#{selector}').val('#{value}').trigger('keydown').trigger('keyup')))
end

Then /^I verify sorted rows in table "(.*?)" in column "(\d+)" by values "(.*?)"$/ do |table, column, values|
  table = page.find("##{table}")
  values.to_s.split(',').each_with_index do |value, index|
    expect(table.find("tbody > tr:nth-child(#{index.to_i+1}) > td:nth-child(#{column})")).to have_content value
  end
end

Given /^PENDING/ do
  pending
end