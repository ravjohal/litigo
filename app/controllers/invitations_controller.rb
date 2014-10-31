class InvitationsController < Devise::InvitationsController
  def create
    users_params = params[:users]
    emails = []
    users_params.each_value do |attrs|
      if User.invite!({email: attrs['email'], firm_id: current_user.firm_id, role: attrs['role'].to_i }, current_user)
        emails << attrs['email']
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