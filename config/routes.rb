Rails.application.routes.draw do

  resources :firms

  resources :notes

  resources :documents

  resources :events

  resources :tasks

  resources :contacts  
  
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
    resources :contacts, :shallow => true
    resources :notes, :shallow => true
    resources :documents, :shallow => true
    resources :tasks, :shallow => true
    resources :incidents
    resources :medicals do
      resources :injuries
    end
  end

  # get '/cases/:id/contacts' => 'contacts#index', as: :case_contacts
  # post '/cases/:id/contacts' => 'contacts#create'
  # get '/cases/:id/contacts/new' => 'contacts#new', as: :new_case_contact
end
