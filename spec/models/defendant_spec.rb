require 'spec_helper'

describe 'Defendant' do
  let!(:defendant) { create(:defendant, married: true, employed: true, job_description: 'programmer', salary: 5000,
                            parent: false, felony_convictions: false, last_ten_years: true, jury_likeability: 5) }

  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :contactable => defendant) }


  context 'Check attributes' do
    it 'Expects Defendant to have valid attrs' do
      expect(defendant.married).to eq true
      expect(defendant.employed).to eq true
      expect(defendant.job_description).to eq 'programmer'
      expect(defendant.salary).to eq 5000
      expect(defendant.parent).to eq false
      expect(defendant.felony_convictions).to eq false
      expect(defendant.last_ten_years).to eq true
      expect(defendant.jury_likeability).to eq 5
    end

    it 'Association' do
      defendant.destroy
      expect(Contact.where(id: contact.id).first).to eq nil
    end

  end

end