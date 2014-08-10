require 'spec_helper'

describe 'Contact' do
  let!(:user) { create(:user) }
  let!(:attorney) { create(:attorney, :attorney_type => 'Lawyer', :firm => 'Firm') }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :contactable => attorney, :user => user) }
  let!(:invalid_contact) { create(:contact, :contactable => attorney) }

  context 'Check attributes' do
    it 'Expects Contact to be valid and have attrs' do
      expect(contact).to be_valid
      expect(contact.first_name).to eq 'John'
      expect(contact.last_name).to eq 'Doh'
    end

    it 'Expects Contact without first_name, last_name to be invalid' do
      !expect(invalid_contact).to be_valid
    end
  end

  context "Checking dependencies" do
    it 'Expects to have valid association with user' do
      expect(contact.user).to eq user
      expect(user.contacts.first).to eq contact
    end

    xit 'expects contact to be destroyed with user' do
      user.destroy
      expect(Contact.where(id: contact.id).first).to eq nil
    end
  end

end