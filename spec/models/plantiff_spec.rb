require 'spec_helper'

describe 'Plantiff' do
  # let!(:plantiff) { create(:plantiff, :married => true, :employed => false, :job_description => 'Taxi driver',
  #                          :salary => 4000, :parent => true, :felony_convictions => false, :last_ten_years => true,
  #                          :jury_likeability => 6) }
  # let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :contactable => plantiff) }


  xit 'Expects Attorney to be valid and have attrs' do
    expect(plantiff.married).to eq true
    expect(plantiff.employed).to eq false
    expect(plantiff.salary).to eq 4000
    expect(plantiff.parent).to eq true
    expect(plantiff.felony_convictions).to eq false
    expect(plantiff.last_ten_years).to eq true
    expect(plantiff.jury_likeability).to eq 6
  end

  xit 'expects contact to be destroyed with plantiff' do
    plantiff.destroy
    expect(Contact.where(id: contact.id).first).to eq nil
  end

end