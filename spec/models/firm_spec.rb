require 'spec_helper'

describe Firm do

  context 'Validations' do
    it { should validate_presence_of(:name) }
  end
end
