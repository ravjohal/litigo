require 'spec_helper'

describe 'Client' do
  let!(:client) { create(:client) }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :contactable => client) }


  context 'Check attributes' do
    it 'Association' do
      expect(contact.contactable).to eq client
      expect(client.contact).to eq contact
    end

  end

end