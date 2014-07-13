Rails.application.routes.draw do
  
  resources :contacts
  resources :clients
  resources :plantiffs
  resources :defendants
  resources :attorneys
  resources :witnesses

  root :to => "visitors#index"
  get '/dashboard/:id' => 'users#show', as: :user_root # TODO: Change the page where this is routed to
  get '/auth/google_oauth2/callback' => 'users#save_google_oauth'

  devise_for :users
  resources :users
  resources :cases
end
