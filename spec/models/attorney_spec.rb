require 'spec_helper'

describe 'Attorney' do
  let!(:attorney) { create(:attorney, :attorney_type => 'Lawyer', :firm => 'Firm') }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :contactable => attorney) }
  let!(:invalid_contact) { create(:contact, :contactable => attorney) }
  let!(:event) { create(:event) }


  context 'Check attributes' do
    it 'Expects Attorney to be valid and have attrs' do
      expect(attorney).to be_valid
      expect(attorney.attorney_type).to eq 'Lawyer'
      expect(attorney.firm).to eq 'Firm'
    end

  end

  context 'Checking dependencies' do

    it 'Expects to have has_and_belongs_to_many Event -> Attorney association' do
      attorney.events << event
      expect(attorney.events.size).to eq 1
      expect(event.attorneys.size).to eq 1

      attorney.events.clear
      event.attorneys.clear
      expect(attorney.events.empty?).to eq true
      expect(event.attorneys.empty?).to eq true
    end

    it 'Expects to have valid associations' do
      expect(contact.contactable).to eq attorney
      expect(attorney.contact).to eq contact
    end

    it 'expects contact to be destroyed with attorney' do
      attorney.destroy
      expect(Contact.where(id: contact.id).first).to eq nil
    end
  end

end