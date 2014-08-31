Rails.application.routes.draw do

  get 'dashboard/index'

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
    root :to => "cases#index", as: :authenticated_root
  end

  root :to => "visitors#index"
  get '/onboarding' => 'dashboard#onboard'
  get '/dashboard/:id' => 'dashboard#index', as: :user_root
  #get '/dashboard/:id' => 'users#show', as: :user_root
  get '/auth/google_oauth2/callback' => 'users#save_google_oauth'

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  resources :users
  resources :cases do
    resources :incidents
  end
end
