Rails.application.routes.draw do
  
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
  get '/dashboard/:id' => 'users#show', as: :user_root # TODO: Change the page where this is routed to
  get '/auth/google_oauth2/callback' => 'users#save_google_oauth'

  devise_for :users
  resources :users
  resources :cases
end
