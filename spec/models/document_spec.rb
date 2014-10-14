require 'spec_helper'

describe Document do

  let!(:cas) { create(:case, number: 7, case_type: 'CType', subtype: 'SubType', name: 'Case1',
                      description: 'Description') }

  let!(:user) { create(:user) }
  let!(:doc) { create(:document, author: 'John Doh', doc_type: 'Doc Type', template: 'tpl', user: user) }


  context 'Check attributes' do
    it 'Expects Document to have attrs' do
      expect(doc.author).to eq 'John Doh'
      expect(doc.doc_type).to eq 'Doc Type'
      expect(doc.template).to eq 'tpl'
    end

  end

  context 'Checking dependencies' do

    it 'Expects to have has_and_belongs_to_many Document -> Case association' do
      doc.cases << cas
      expect(doc.cases.size).to eq 1
      expect(cas.documents.size).to eq 1
      expect(cas.documents.first).to eq doc

      doc.cases.clear
      cas.documents.clear
      expect(doc.cases.empty?).to eq true
      expect(cas.documents.empty?).to eq true
    end

    it 'Expects to have a valid User associations' do
      expect(doc.user).to eq user
      expect(user.documents.first).to eq doc
    end

  end

end
