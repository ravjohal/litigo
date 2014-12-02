require 'spec_helper'

describe Resolution do
  context 'Relationships' do
    it { should belong_to(:case) }
    it { should belong_to(:firm) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do

  end
end
