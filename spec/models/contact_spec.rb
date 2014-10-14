require 'spec_helper'

describe Contact do
  let!(:user) { create(:user) }
  let!(:attorney) { create(:attorney, :attorney_type => 'Lawyer') }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :user => user,
                          :middle_name => 'Aron', :address => 'Avenue, 5th', :city => 'New York', :state => 'New York',
                          :country => 'USA', :phone_number => 111222, :fax_number => 333444,
                          :email => 'contact@server.com', :gender => 'male', :age => 30) }

  let!(:invalid_contact) { create(:contact) }
  
  context 'Validations' do
    it { should validate_presence_of(:type) }
  end

  context 'Check attributes' do
    it 'Expects Contact to be valid and have attrs' do
      expect(contact).to be_valid
      expect(contact.first_name).to eq 'John'
      expect(contact.last_name).to eq 'Doh'
      expect(contact.middle_name).to eq 'Aron'
      expect(contact.address).to eq 'Avenue, 5th'
      expect(contact.city).to eq 'New York'
      expect(contact.state).to eq 'New York'
      expect(contact.country).to eq 'USA'
      expect(contact.phone_number).to eq '111222'
      expect(contact.fax_number).to eq 333444
      expect(contact.email).to eq 'contact@server.com'
      expect(contact.gender).to eq 'male'
      expect(contact.age).to eq 30
    end

    it 'Expects Contact without first_name, last_name to be invalid' do
      !expect(invalid_contact).to be_valid
    end
  end

  context "Checking dependencies" do
    xit 'Expects to have valid association with user' do
      expect(contact.user).to eq user
      expect(user.contacts.first).to eq contact
    end

  end

end
