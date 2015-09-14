require 'spec_helper'

describe User do

  let!(:user) { create(:user, name: 'JohnDoh', unconfirmed_email: 'unconfirmed@email.com',
                       show_onboarding: true, oauth_refresh_token: 'Token', oauth_token: 'Token1',
                       oauth_expires_at: Date.today, google_email: 'box@gmail.com') }

  context 'Relationships' do
    it { should define_enum_for(:role).
                    with([:staff, :admin, :attorney]) }
    it { should have_many :documents }
    it { should have_many :tasks }
    it { should have_many(:user_events).dependent(:destroy) }
    it { should have_many(:events).through(:user_events) }
    it { should have_many(:owned_events).class_name('Event').with_foreign_key('owner_id') }
    it { should have_many :contacts }
    it { should have_one(:contact_user).class_name('Contact').with_foreign_key('user_account_id') }
    it { should have_many :cases }
    it { should have_many :notes }
    it { should have_many :google_calendars }
    it { should have_many(:leads).class_name('Lead').with_foreign_key('attorney_id') }

    it { should have_many(:notes_users).with_foreign_key('secondary_owner_id') }
    it { should have_many(:secondary_notes).class_name('Note').through(:notes_users) }

    it { should belong_to :firm }
  end

  context 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it {should validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map { |m| m.name }) }
  end

  context 'Accessible attributes' do
    it { should accept_nested_attributes_for(:firm) }
  end

  #factories
  let!(:user) { create(:user, first_name: 'Ben', last_name: 'Smalley') }

  describe "#name" do
    it "returns the correct full name" do
      user.name.should == "Ben Smalley"
    end
  end

  describe "#set_default_role" do
    it "sets staff default role" do
      user.role.should == "staff"
    end
  end

end
