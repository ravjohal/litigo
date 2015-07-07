require 'spec_helper'

describe Contact do

  context 'Relationships' do
    it { should have_many(:cases) }
    it { should belong_to(:user) }
    it { should belong_to(:event) }
    it { should belong_to(:user_account).class_name('User') }
    it { should belong_to(:firm) }
  end

  context 'Validations' do
    # it { should validate_presence_of(:type) }
    # it { should validate_presence_of(:first_name) }
    # it { should validate_presence_of(:last_name) }
    it { should ensure_length_of(:phone_number).is_at_most(10) }
    xit { should ensure_length_of(:fax_number).is_at_most(10) }
  end

  context 'Accessible attributes' do
    it { should respond_to(:first_name, :last_name, :middle_name, :address, :city, 
                           :state, :country, :phone_number, :fax_number, :email, :gender, :age, :user, :event, :phone_number, :fax_number ) }
  end



end
