require 'spec_helper'

describe 'Client' do
  let!(:witness) { create(:witness, witness_type: 'type', witness_subtype: 'subtype', witness_doctype: 'doctype', ) }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :contactable => witness) }


  context 'Check attributes' do
    it 'Expects Witness to have following attrs' do
      expect(witness.witness_type).to eq 'type'
      expect(witness.witness_subtype).to eq 'subtype'
      expect(witness.witness_doctype).to eq 'doctype'
    end

    it 'Association' do
      expect(witness.contact).to eq contact
      expect(contact.contactable).to eq witness

      witness.destroy
      expect(Contact.where(id: contact.id).first).to eq nil
    end

  end

end