require 'spec_helper'

describe Event do
  context 'Relationships' do
    it { should have_many(:user_events).dependent(:destroy) }
    it { should have_many(:users).through(:user_events) }
    it { should have_many(:case_events).dependent(:destroy) }
    it { should have_many(:cases).through(:case_events) }
    it { should have_many(:event_attendees).dependent(:destroy) }
    it { should have_many(:contacts) }

    it { should belong_to(:owner).class_name('User') }
    it { should belong_to(:firm) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do
    it { should respond_to(:user_events, :users, :cases, :event_attendees, :contacts, :owner, :firm ) }
  end
end
