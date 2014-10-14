require 'spec_helper'

describe Note do

  let!(:user) { create(:user) }
  let!(:cas) { create(:case, number: 7, case_type: 'CType', subtype: 'SubType', name: 'Case1',
                      description: 'Description') }

  let!(:note) { create(:note, note: 'Note', note_type: 'Type', author: 'Author', user: user, case: cas) }

  it 'Expects Note to be valid and have attrs' do
    expect(note.note).to eq 'Note'
    expect(note.note_type).to eq 'Type'
    expect(note.author).to eq 'Author'
  end

  it 'Expects note to belong to case and user' do
    expect(note.user).to eq user
    expect(note.case).to eq cas
  end

end
