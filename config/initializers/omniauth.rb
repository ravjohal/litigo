Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/contacts.readonly',
    redirect_uri: "http://request.host_with_port/auth/google_oauth2/callback", #TODO: make this a configurable host
    access_type: 'offline',
    prompt: 'consent'
  }
end
