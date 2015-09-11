require 'spec_helper'

describe Note do
  context 'Relationships' do
    it { should belong_to(:case) }
    it { should belong_to(:user) }
    it { should belong_to(:firm) }
    it { should have_many(:notes_users).with_foreign_key('secondary_note_id') }
    it { should have_many(:secondary_owners).class_name('User').through(:notes_users) }
  end

  context 'Validations' do
    it { should respond_to(:author, :note_type, :note) }
  end

  context 'Accessible attributes' do
  end
end
