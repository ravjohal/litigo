require 'spec_helper'

describe GoogleCalendar do
  context 'Relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:firm) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do
    it { should respond_to(:user, :firm) }
  end
end
