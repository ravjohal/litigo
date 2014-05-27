Rails.application.routes.draw do
  root :to => "visitors#index"
  get '/dashboard/:id' => 'users#show', as: :user_root # TODO: Change the page where this is routed to
  devise_for :users
  resources :users
end
