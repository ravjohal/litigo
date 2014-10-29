Then(/^I create a note$/) do
  visit '/notes'
  click_on 'NEW NOTE'
  find("option[value='Medical/Review']").click
  click_on 'Create Note'
  expect(page).to have_content('Note was successfully created.')
end

Then(/^The note for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Note.where(id: u.id).first.note_type).to eq 'Medical/Review'
  expect(Note.where(id: u.id).first.author).to eq 'Artem Suchov'
end