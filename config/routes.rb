Rails.application.routes.draw do


  get 'reports' => 'reports#index', as: :reports
  get 'reports/show' => 'reports#show', as: :report_show
  get 'reports/all_leads_by_channel' => 'reports#leads_by_channel_report', as: :reports_leads_by_channel
  get 'reports/all_leads_detail/(:marketing_channel_arg)(.:format)' => 'reports#leads_detail_report', as: :reports_leads_detail
  get 'reports/cases_statute_of_limitations' => 'reports#case_sol_report', as: :reports_case_sol
  get 'reports/open_close' => 'reports#open_close_report', as: :reports_open_close
  get 'reports/medical_bills_totals' => 'reports#medical_bills_report', as: :reports_medical_bills
  get 'reports/cases_by_attorneys' => 'reports#cases_by_attorney_report', as: :reports_cases_by_attorney
  get 'reports/cases_by_statuses' => 'reports#cases_by_status_report', as: :reports_cases_by_status

  resources :companies
  resources :templates
  patch 'templates/update_html/:id' => 'templates#update_html'
  get 'templates/generate_document/:id' => 'templates#generate_document', as: :generate_document
  post 'templates_get_case' => 'templates#get_case', as: :get_case
  post 'templates_get_addressee' => 'templates#get_addressee', as: :get_addressee_attrs
  post 'templates_generate_docx' => 'templates#generate_docx', as: :generate_docx
  get 'download_docx/:id' => 'templates#download_docx', as: :download_docx

  resources :time_entries, :except => [:new]
  put 'set_timer' => 'time_entries#set_timer', as: :set_timer
  put 'get_timer' => 'time_entries#get_timer', as: :get_timer
  put 'reset_timer' => 'time_entries#reset_timer', as: :reset_timer

  resources :task_lists
  post 'task_lists/import_to_case' => 'task_lists#import_to_case', as: :task_lists_import_to_case
  resources :firms

  resources :notes

  resources :documents

  resources :events

  resources :client_intakes, as: 'leads'
  get '/client_intakes_contacts/:id' => 'client_intakes#show_lead_contact', as: :lead_contact
  get '/client_intakes_contacts/:id/edit' => 'client_intakes#edit_lead_contact', as: :edit_lead_contact
  get '/client_intakes_documents/:id' => 'client_intakes#lead_documents', as: :lead_documents
  get '/client_intakes/:id/acceptance_letter' => 'client_intakes#acceptance_letter', as: :acceptance_letter

  resources :tasks
  post 'tasks/complete_task' => 'tasks#complete_task'
  get 'get_tasks' => 'tasks#get_tasks', as: :get_tasks

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
  get '/auth/failure' => 'users#fail_google_oauth'
  get 'refresh_google_events' => 'events#refresh_google_events'
  # get '/dashboards/select_calendar'
  post '/dashboards/select_calendar'
  get  "dropbox/main"
  post "dropbox/upload"
  get  "dropbox/auth_start"
  get  "dropbox/auth_finish"
  get 'login_callback' => 'nylas#login_callback'
  get 'login' => 'nylas#login'

  # Visitor routes
  get "/about" => 'visitors#about', as: :about
  get "/terms" => 'visitors#terms', as: :terms
  get "index" => 'visitors', as: :index
  get "/contact" => 'visitors#contactlitigo', as: :contactlitigo
  get "/privacy" => 'visitors#privacy', as: :privacy
  get "/pricing" => 'visitors#pricing', as: :pricing
  get "/partners" => 'visitors#partners', as: :partners
  get "/confirm" => 'visitors#confirm_signin_email', as: :confirm_signin_email

  resources :dashboards, path: "dashboard"

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions" , :invitations => 'invitations'}
  devise_scope :user do
    get 'users/profile' => 'registrations#profile'
    get 'users/settings' => 'registrations#settings'
    get 'users/admin' => 'registrations#admin'
    get '/confirm/:id' => 'registrations#confirm_signup_email', as: :confirm_signup_email
    patch '/users/update_profile' => 'registrations#update_profile'
    get "/users/invitation/existing_user_invited/:id" => 'invitations#existing_user_invited', as: :existing_user_invited

  end
  resources :expenses
  resources :users
  resources :cases do
    resources :contacts, :shallow => true
    resources :notes, :shallow => true
    resources :documents, :shallow => true
    resources :tasks, :shallow => true
    resources :incidents
    resources :resolutions
    resources :medicals
    resources :insurances
    resources :expenses
  end

  get "cases/:id/summary" => 'cases#summary', as: :case_summary
  get "user_cases" => "cases#user_cases", :defaults => { :format => :json }
  get "user_leads" => "client_intakes#user_leads", :defaults => { :format => :json }
  get "accept_case/:id" => 'client_intakes#accept_case', as: :accept_case
  get 'cases/:id/doc' => 'cases#doc', as: :doc
  get "contacts/:id/contact information" => 'contacts#info', as: :contact_info
  get "contacts/:id/personal information" => 'contacts#personal', as: :contact_personal
  get "contacts/:id/company information" => 'contacts#coinfo', as: :contact_coinfo

  resources :medicals do
    resources :injuries
  end
  get "emails_autocomplete" => "events#emails_autocomplete"
  post "event_drag" => "events#event_drag"
  post "get_user_events" => "events#get_user_events", as: :get_user_events
  post "send_feedback_clean" => "users#send_feedback_clean", :defaults => { :format => :json }
end
