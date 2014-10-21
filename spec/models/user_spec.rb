require 'spec_helper'

describe User do

  let!(:user) { create(:user, name: 'JohnDoh', unconfirmed_email: 'unconfirmed@email.com',
                       show_onboarding: true, oauth_refresh_token: 'Token', oauth_token: 'Token1',
                       oauth_expires_at: Date.today, google_email: 'box@gmail.com') }

  context 'Relationships' do
    it { should define_enum_for :role }
    it { should have_many :documents }
    it { should have_many :tasks }
    it { should have_many(:user_events).dependent(:destroy) }
    it { should have_many(:events).through(:user_events) }
    it { should have_many(:owned_events).class_name('Event').with_foreign_key('owner_id') }
    it { should have_many :contacts }
    it { should have_one(:contact_user).class_name('Contact').with_foreign_key('contact_user_id') }
    it { should have_many :cases }
    it { should have_many :notes }
    it { should have_many :google_calendars }

    it { should belong_to :firm }
  end

  context 'Validations' do
    it {should ensure_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map { |m| m.name }) }
  end

  context 'Accessible attributes' do

  end
end
