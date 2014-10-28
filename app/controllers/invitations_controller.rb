class InvitationsController < Devise::InvitationsController
  def create
    users_params = params[:users]
    emails = []
    users_params.each_value do |attrs|
      email_match = attrs['email'].match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)
      return false unless  email_match.present?
      email = email_match[0]
      role = attrs['role'] == 'stuff' ? 0 : 2
      if User.invite!({email: email, firm_id: current_user.firm_id, role: role }, current_user)
        emails << email
      end
    end

    respond_to do |format|
      if emails.present?
        format.html { redirect_to root_path, notice: "Invitations were sent to: #{emails.to_sentence}" }
      else
        flash[:notice] = "Email weren't sent"
        format.html { render :new }
      end
    end
  end

  def update
    super
    resource.name = resource.first_name + " " + resource.last_name
    resource.save
  end
end