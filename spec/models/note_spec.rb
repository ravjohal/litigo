require 'spec_helper'

describe Note do
  context 'Relationships' do
    it { should belong_to(:case) }
    it { should belong_to(:user) }
    it { should belong_to(:firm) }
  end

  context 'Validations' do
    it { should respond_to(:author, :note_type, :note) }
  end

  context 'Accessible attributes' do
  end
end
