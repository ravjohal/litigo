class InvitationsController < Devise::SessionsController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
	
end