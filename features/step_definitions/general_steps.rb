
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

Given /^PENDING/ do
  pending
end