Then(/^I create the document$/) do
  visit '/documents'
  click_on 'NEW DOCUMENT'
  fill_in 'document_doc_type', with: 'text'
  click_on 'Create Document'
  expect(page).to have_content('Document was successfully created.')
end

When /^I edit the document$/ do
  within '#my_docs' do
    first('tr > td > a.dark-small > span.glyphicon-pencil').click
  end
  sleep 0.3
  fill_in 'document_doc_type', with: 'new doc desc'
  click_on 'Save'
end

When /^I delete the document$/ do
  within '#my_docs' do
    first('tr > td > a.dark-small > span.glyphicon-trash').click
  end
  sleep 0.3
  step 'I confirm popup'
end

Then(/^I create the document with file upload$/) do
  visit '/documents'
  click_on 'NEW DOCUMENT'
  fill_in 'document_doc_type', with: 'text'
  attach_file(:document_document, Rails.root.join('features', 'upload-files', 'document_ok.txt'))
  click_on 'Create Document'
end

Then(/^The document for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Document.where(id: u.id).first.doc_type).to eq 'text'
end

Then(/^The document with file for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  document = Document.where(id: u.id).first
  expect(document.doc_type).to eq 'text'
  expect(document.document.instance_of?DocumentUploader).to be_truthy
  expect(document.document.to_s.split('/').last).to eq 'document_ok.txt'
end

Then(/^I create the document through case management$/) do
  click_on 'Case Management'
  click_on 'DOCUMENTS'
  click_on 'NEW DOCUMENT'
  fill_in 'document_doc_type', with: 'some type'
  click_on 'Create Document'
  expect(page).to have_content('Document was successfully created.')
end

Then(/^The document for user with email "(.*?)" should be saved to the db with the right fields$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Document.where(id: u.id).first.author).to eq 'Artem Suchov'
  expect(Document.where(id: u.id).first.doc_type).to eq 'some type'
end

Then /^I verify edited document for user "(.*?)"$/ do |email|
  u = User.where(email: email).first
  expect(Document.where(id: u.id).first.doc_type).to eq 'new doc desc'
end

Then /^I verify deleted document for user "(.*?)"$/ do |email|
  u = User.where(email: email).first
  expect(u.documents.size).to eq 0
end

