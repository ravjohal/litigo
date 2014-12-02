Rails.application.routes.draw do

  resources :firms

  resources :notes

  resources :documents

  resources :events

  resources :tasks
  post 'tasks/complete_task' => 'tasks#complete_task'

  resources :contacts

  resources :insights do
    collection do
      get :filter_cases
    end
  end
  
  authenticated :user do
    root :to => "dashboards#new", as: :user_root
    #root :to => 'business_account#dashboard', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Business' }, :as => "business_root"
  end

  root :to => "visitors#index"
  get '/onboarding' => 'dashboards#new'
  get '/dashboard/:id' => 'dashboards#show'
  get '/get_counties_by_state' => 'insights#get_counties_by_state'
  #post '/dashboard/:name' => 'dashboard#create_firm_contact', as: 'dashboard_create_firm_contact'
  #get '/dashboard/:id' => 'users#show', as: :user_root
  get '/auth/google_oauth2/callback' => 'users#save_google_oauth'
  get 'refresh_google_events' => 'events#refresh_google_events'
  get '/users/select_calendar'
  # get '/users/settings'
  # get '/users/profile'
  # patch '/users/update_profile'
  # get '/users/admin'
  get  "dropbox/main"
  post "dropbox/upload"
  get  "dropbox/auth_start"
  get  "dropbox/auth_finish"

  # Visitor routes
  get "/about" => 'visitors#about', as: :about
  get "/terms" => 'visitors#terms', as: :terms
  get "index" => 'visitors', as: :index
  get "/contact" => 'visitors#contactlitigo', as: :contactlitigo
  get "/privacy" => 'visitors#privacy', as: :privacy
  get "/pricing" => 'visitors#pricing', as: :pricing
  get "/partners" => 'visitors#partners', as: :partners

  resources :dashboards, path: "dashboard"

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions" , :invitations => 'invitations'}
  devise_scope :user do
    get 'users/profile' => 'registrations#profile'
    get 'users/settings' => 'registrations#settings'
    get 'users/admin' => 'registrations#admin'
  end

  resources :users
  resources :cases do
    resources :contacts, :shallow => true
    resources :notes, :shallow => true
    resources :documents, :shallow => true
    resources :tasks, :shallow => true
    resources :incidents
    resources :resolutions
    resources :medicals
  end

  resources :medicals do
    resources :injuries
  end
  get "emails_autocomplete" => "events#emails_autocomplete"
end
