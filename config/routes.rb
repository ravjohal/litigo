Rails.application.routes.draw do
  
  resources :contacts
  resources :clients
  resources :plantiffs
  resources :defendants
  resources :attorneys
  resources :witnesses

  root :to => "visitors#index"
  get '/dashboard/:id' => 'users#show', as: :user_root # TODO: Change the page where this is routed to
  get "case/new_modal" => 'case#new_modal', :as => :new_modal

  devise_for :users
  resources :users
  resources :cases
end
