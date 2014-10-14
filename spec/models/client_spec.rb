require 'spec_helper'

describe Client do
  let!(:witness) { create(:witness, witness_type: 'type', witness_subtype: 'subtype', witness_doctype: 'doctype', ) }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh') }


  context 'Check attributes' do
    it 'Expects Witness to have following attrs' do
      expect(witness.witness_type).to eq 'type'
      expect(witness.witness_subtype).to eq 'subtype'
      expect(witness.witness_doctype).to eq 'doctype'
    end

    it 'Association' do


      # expect(Contact.where(id: contact.id).first).to eq nil
    end

  end

end
