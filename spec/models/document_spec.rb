require 'spec_helper'

describe Document do

  let!(:cas) { create(:case, case_type: 'CType', subtype: 'SubType', name: 'Case1',
                      description: 'Description') }

  let!(:user) { create(:user) }
  let!(:doc) { create(:document, author: 'John Doh', doc_type: 'Doc Type', template: 'tpl', user: user) }

  context 'Relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:firm) }
    it { should have_many(:case_documents).dependent(:destroy) }
    it { should have_many(:cases).through(:case_documents) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do
    it { should respond_to(:user, :firm, :case_documents, :cases) }
  end

end
