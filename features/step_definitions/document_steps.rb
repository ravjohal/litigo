Then(/^I create the document$/) do
  visit '/documents'
  click_on 'NEW DOCUMENT'
  fill_in 'document_doc_type', with: 'text'
  click_on 'Create Document'
  expect(page).to have_content('Document was successfully created.')
end

Then(/^The document for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Document.where(id: u.id).first.doc_type).to eq 'text'
end