require 'spec_helper'

describe EventAttendee do
  context 'Relationships' do
    it { should belong_to(:event) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do
    it { should respond_to(:event) }
  end
end
