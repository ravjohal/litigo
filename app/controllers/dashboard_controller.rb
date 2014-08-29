class DashboardController < ApplicationController
  before_action :set_user
  
  def onboard
  	if @contact
  		@user_contact = @contact
  	else
  		@user_contact = Contact.new
  	end
  end

  def index
  end
end
