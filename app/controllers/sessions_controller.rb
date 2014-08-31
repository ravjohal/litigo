class SessionsController < Devise::SessionsController

	def destroy
		Apartment::Tenant.switch()
		super
	end
end