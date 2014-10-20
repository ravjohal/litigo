require 'spec_helper'

describe Injury do
  context 'Relationships' do
    it { should belong_to(:medical) }
    it { should belong_to(:firm) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do
    it { should respond_to(:medical, :firm) }
  end
end
