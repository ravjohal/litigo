require 'spec_helper'

describe NotesUser do
  context 'Relationships' do
    it { should belong_to(:secondary_owner).class_name('User').with_foreign_key('secondary_owner_id') }
    it { should belong_to(:secondary_note).class_name('Note').with_foreign_key('secondary_note_id') }
  end
end