require 'spec_helper'

describe Event do

  let!(:user) { create(:user) }
  let!(:attorney) { create(:attorney, :attorney_type => 'Lawyer') }
  let!(:cas) { create(:case, number: 7, case_type: 'CType', subtype: 'SubType', name: 'Case1',
                      description: 'Description') }

  let!(:event) { create(:event, subject: 'Subj', location: 'location', date: Date.today, time: Time.now, all_day: true,
                        reminder: false, notes: 'Text', owner: user) }

  context 'Check attributes' do
    it 'Expects Event to be valid and have attrs' do
      expect(event.subject).to eq 'Subj'
      expect(event.location).to eq 'location'
      expect(event.date).to eq Date.today
      expect(event.all_day).to eq true
      expect(event.reminder).to eq false
      expect(event.notes).to eq 'Text'
    end

  end

  context 'Checking dependencies' do

    it 'Expects to have an owner' do
      expect(event.owner).to eq user
      expect(user.owned_events.first).to eq event
    end

    xit 'Expects to have has_and_belongs_to_many Case -> Event association' do
      attorney.events << event
      expect(attorney.events.size).to eq 1
      expect(attorney.events.first).to eq event

    end
  end
end
