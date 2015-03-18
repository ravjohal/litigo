class InvitationsController < Devise::InvitationsController

  def new
    @firm = current_user.firm
  end

  # Creates the invitation(s) (is called after the new action is taken)
  def create
    users_params = params[:users]
    emails = []
    users_params.each_value do |attrs|
      user = User.find_by(email: attrs['email'])
      if !user.present?
        user = User.new(email: attrs['email'], firm_id: current_user.firm_id, role: attrs['role'].to_i)
      end
        # if the user is in the system, then invite the person this way
      #   @raw_invitation_token = Devise.token_generator.generate(User, :invitation_token)
      #   logger.info "@raw_invitation_token: #{@raw_invitation_token}\n\n\n"
      #   user.invitation_token = @raw_invitation_token[1]
      #   user.invitation_created_at = Time.now.utc
      #   user.invitation_sent_at = user.invitation_created_at
      #   user.invitation_role = attrs['role'].to_i
      #   user.invited_by = current_user
      #   options = {user: user, admin: current_user, token: @raw_invitation_token[0], role: User::USER_ROLES[attrs['role'].to_i]}
      #   # puts "ADMIN WHAT IS ADMIN ----------> " + options.inspect
      #   UserEmails.invite_existing_user(options).deliver if user.save(:validate => false)
      # else
      #   # if the user is NOT in the system, then send out invite this way (it also creates a user)
      #   puts "IS THIS WHERE I AM ---------------------> "
      #   @raw_invitation_token = Devise.token_generator.generate(User, :invitation_token)
      #   user = User.new(email: attrs['email'], firm_id: current_user.firm_id, role: attrs['role'].to_i)
      #   options = {user: user, admin: current_user, token: @raw_invitation_token[0], role: [attrs['role'].to_i]}
      #   #user.save!
      #   UserEmails.invite_new_user(options).deliver if user.save(:validate => false)
        #user = User.invite!({email: attrs['email'], firm_id: current_user.firm_id, role: attrs['role'].to_i }, current_user)
      #end
        @raw_invitation_token = Devise.token_generator.generate(User, :invitation_token)
        logger.info "@raw_invitation_token: #{@raw_invitation_token}\n\n\n"
        user.invitation_token = @raw_invitation_token[1]
        user.invitation_created_at = Time.now.utc
        user.invitation_sent_at = user.invitation_created_at
        user.invitation_role = attrs['role'].to_i
        user.invited_by = current_user
        options = {user: user, admin: current_user, token: @raw_invitation_token[0], role: User::USER_ROLES[attrs['role'].to_i]}
        # puts "ADMIN WHAT IS ADMIN ----------> " + options.inspect
        UserEmails.invite_existing_user(options).deliver if user.save(:validate => false)

        emails << attrs['email']
    end

    respond_to do |format|
      if emails.present?
        format.html { redirect_to root_path, notice: "Invitations were sent to: #{emails.to_sentence}" }
      else
        flash[:notice] = "Email was not sent"
        format.html { render :new }
      end
    end
  end

  def edit
    
  end

  def update
    invitation_token = Devise.token_generator.digest(User, :invitation_token, params[:invitation_token])
    user = User.find_by(invitation_token: invitation_token)
    if user.present? && user.encrypted_password.present?
      puts "WHERE AM I ?  ------ Looks like EDIT ------ "
      user.accept_invitation
      inviter = User.find(user.invited_by_id)
      user.firm_id = inviter.firm_id
      user.role = user.invitation_role
      puts "INVITATION ROLE WHEN SIGNED UP -------------> " + user.role.to_s
      user.invitation_role = nil
      user.save!

      redirect_to root_path, notice: 'Invitation accepted.'
    else
      super
      # resource.name = resource.first_name + " " + resource.last_name
      # resource.save
    end
 #   super


    # class_string_name = User::USER_ROLES[current_user.role].humanize
    # puts "CONTACT TYPE ------> " + class_string_name
    # create_contact(class_string_name, current_user, current_user.firm)
  end
end