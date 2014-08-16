require 'spec_helper'

describe 'Case' do

  let!(:user) { create(:user) }
  let!(:attorney) { create(:attorney, :attorney_type => 'Lawyer', :firm => 'Firm') }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :contactable => attorney) }
  let!(:cas) { create(:case, number: 7, case_type: 'CType', subtype: 'SubType', name: 'Case1',
                       description: 'Description') }

  let!(:event) { create(:event) }
  let!(:doc) { create(:document) }
  let!(:task) { create(:task) }

  context 'Check attributes' do
    it 'Expects Case to be valid and have attrs' do
      expect(cas).to be_valid
      expect(cas.case_type).to eq 'CType'
      expect(cas.subtype).to eq 'SubType'
      expect(cas.name).to eq 'Case1'
      expect(cas.description).to eq 'Description'
    end

    xit 'Expects to have valid associations' do
      expect(cas.contact).to eq contact
      expect(cas.contactable).to eq attorney
    end

  end

  context 'Checking dependencies' do

    it 'Expects to have has_and_belongs_to_many Case -> Event association' do
      cas.events << event
      expect(cas.events.size).to eq 1
      expect(cas.events.first).to eq event


      cas.events.clear
      event.cases.clear
      expect(cas.events.empty?).to eq true
      expect(event.cases.empty?).to eq true
    end
  end
end