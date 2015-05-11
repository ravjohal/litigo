Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/contacts.readonly',
    redirect_uri: "#{gethostforurl}/auth/google_oauth2/callback", #TODO: make this a configurable host
    access_type: 'offline',
    prompt: 'consent'
  }
end

def gethostforurl
	hostname_envs   = case
    when Rails.env.production?
      'https://www.litigo.co'
    when Rails.env.staging?
      'litigorav.herokuapp.com'
    else
      'localhost:3000'
    end
end