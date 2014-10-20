require 'spec_helper'

describe Client do
  let!(:witness) { create(:witness, witness_type: 'type', witness_subtype: 'subtype', witness_doctype: 'doctype', ) }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh') }

end
