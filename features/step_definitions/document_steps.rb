Then(/^I create the document$/) do
  visit '/documents'
  click_on 'NEW DOCUMENT'
  fill_in 'document_doc_type', with: 'text'
  click_on 'Create Document'
  expect(page).to have_content('Document was successfully created.')
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

