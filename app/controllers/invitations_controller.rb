class InvitationsController < Devise::InvitationsController
  def create
    emails = []
    params[:user_emails].split(",").each do |email|
      email = email.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)[0]
       if User.invite!({:email => email, :firm_id => current_user.firm_id}, current_user)
         emails << email
       end
    end
    redirect_to root_path, notice: "Invitations were sent to: #{emails.to_sentence}"
  end

  def update
    super
    resource.name = resource.first_name + " " + resource.last_name
    resource.save
  end
end