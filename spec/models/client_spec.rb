require 'spec_helper'

describe 'Client' do
  let!(:client) { create(:client) }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh') }


  context 'Check attributes' do
    xit 'Association' do
      expect(contact.contactable).to eq client
      expect(client.contact).to eq contact
    end

  end

end