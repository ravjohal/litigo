require 'spec_helper'

describe Incident do
  context 'Relationships' do
    it { should belong_to(:case) }
    it { should belong_to(:firm) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do
    it { should respond_to(:case, :firm) }
  end
end
