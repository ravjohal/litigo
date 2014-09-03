Rails.application.routes.draw do

  resources :firms

  resources :staffs

  resources :notes

  resources :documents

  resources :events

  resources :tasks

  resources :contacts
  resources :clients
  resources :plantiffs
  resources :defendants
  resources :attorneys
  resources :witnesses

  authenticated :user do
    root :to => "dashboards#show", as: :authenticated_root
  end

  root :to => "visitors#index"
  get '/onboarding' => 'dashboards#new'
  get '/dashboard/:id' => 'dashboards#show', as: :user_root
  #post '/dashboard/:name' => 'dashboard#create_firm_contact', as: 'dashboard_create_firm_contact'
  #get '/dashboard/:id' => 'users#show', as: :user_root
  get '/auth/google_oauth2/callback' => 'users#save_google_oauth'

  resources :dashboards, path: "dashboard"

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  resources :users
  resources :cases do
    resources :incidents
  end
end
