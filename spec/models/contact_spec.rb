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

  # describe '#similar_contact?' do
  #   let!(:contact) {create :contact}
  #   let(:contact_similar) {build :contact_similar}
  #   let(:contact_another) {build :contact_another}
  #
  #   context 'when we have similar contact' do
  #     it 'must return true' { contact_similar.similar_contact?.should be_true }
  #     it 'must return false' { contact_another.similar_contact?.should be_false }
  #   end
  # end

  # describe '#similar_contact' do
  #   let!(:contact) {create :contact}
  #   let(:contact_similar) {build :contact_similar}
  #   let(:contact_another) {build :contact_another}
  #
  #   context 'when we have similar contact' do
  #     it 'must find similar' { contact_similar.similar_contact.should == contact }
  #     it 'must not find similar' { contact_another.similar_contact.should != contact }
  #   end
  # end

  # describe '#check_similar' do
  #   context 'when we have similar contact' do
  #     let!(:contact) {create :contact}
  #     let(:contact_similar) {build :contact_similar}
  #     it 'must be invalid' { contact_similar.valid?.should be_false }
  #     it 'must be valid with sure' {
  #       contact_similar.sure!
  #       contact_similar.valid?.should be_true
  #     }
  #   end
  #
  # end

end