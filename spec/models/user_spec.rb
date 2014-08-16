require 'spec_helper'

describe 'User' do

  let!(:user) { create(:user, name: 'JohnDoh', unconfirmed_email: 'unconfirmed@email.com', role: :user,
                       show_onboarding: true, oauth_refresh_token: 'Token', oauth_token: 'Token1',
                       oauth_expires_at: Date.today, google_email: 'box@gmail.com') }

  context 'Check attributes' do
    it 'Expects User to be valid and have attrs' do
      expect(user.name).to eq 'JohnDoh'
      expect(user.unconfirmed_email).to eq 'unconfirmed@email.com'
      expect(user.role).to eq 'user'
      expect(user.show_onboarding).to eq true
      expect(user.oauth_refresh_token).to eq 'Token'
      expect(user.oauth_token).to eq 'Token1'
      expect(user.oauth_expires_at).to eq Date.today
      expect(user.google_email).to eq 'box@gmail.com'
    end


  end

end