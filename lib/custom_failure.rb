class CustomFailure < Devise::FailureApp
    # def redirect_url
    #    new_user_session_url(:subdomain => 'secure')
    # end

    def redirect_url
      if warden_message == :unconfirmed
        confirm_email_path
      else
        super
      end
    end

    # You need to override respond to eliminate recall
    def respond
      if http_auth?
        http_auth
      else
        redirect
      end
    end
  end