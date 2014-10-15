require 'spec_helper'

describe Contact do
  let!(:user) { create(:user) }
  let!(:attorney) { create(:attorney, :attorney_type => 'Lawyer') }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh', :user => user,
                          :middle_name => 'Aron', :address => 'Avenue, 5th', :city => 'New York', :state => 'New York',
                          :country => 'USA', :phone_number => 111222, :fax_number => 333444,
                          :email => 'contact@server.com', :gender => 'male', :age => 30) }

  let!(:invalid_contact) { create(:contact) }

  context 'Relationships' do
    it { should belong_to(:case) }
    it { should belong_to(:user) }
    it { should belong_to(:event) }
    it { should belong_to(:user_account).class_name('User') }
    it { should belong_to(:firm) }
  end

  context 'Validations' do
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should ensure_length_of(:phone_number).is_at_most(10) }
    xit { should ensure_length_of(:fax_number).is_at_most(10) }
  end

  context 'Accessible attributes' do
    it { should respond_to(:first_name, :last_name, :middle_name, :address, :city, 
                           :state, :country, :phone_number, :fax_number, :email, :gender, :age, :case, :user, :event, :phone_number, :fax_number ) }
  end

end
