require 'spec_helper'

describe Firm do
  context 'Relationships' do
    it { should have_many(:users) }
    it { should have_many(:cases) }
    it { should have_many(:contacts) }
    it { should have_many(:documents) }
    it { should have_many(:events) }
    it { should have_many(:incidents) }
    it { should have_many(:medicals) }
    it { should have_many(:injuries) }
    it { should have_many(:notes) }
    it { should have_many(:tasks) }
    it { should have_many(:resolutions) }
    it { should have_many(:google_calendars) }
  end

  context 'Accessible attributes' do
    it { should respond_to(:name, :users, :cases, :contacts, :documents, :events, :incidents, :medicals, 
                          :injuries, :notes, :tasks, :treatments, :resolutions, :google_calendars) }
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
  end
end
