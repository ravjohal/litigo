source 'https://rubygems.org'
ruby '2.1.3'
gem 'rails', '~> 4.2.0.beta2'
gem 'ffi', '~> 1.9.5'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'bootstrap-sass', '~> 3.2.0.2'
gem 'autoprefixer-rails'
gem 'devise'
gem 'pg'
gem 'pundit'
gem 'simple_form'
gem 'unicorn'
gem 'carrierwave'
gem 'figaro'
gem 'font-awesome-rails'
gem 'omniauth-google-oauth2', '~> 0.2.5'    # Allows oauth2 support for Google
gem 'will_paginate', '~> 3.0.7'
gem 'rest-client', '~> 1.7.1'               # Replacement for curl commands to grab contacts from google
gem 'active_link_to', '~> 1.0.2'
gem 'jquery-datatables-rails', '~> 2.2.3'
gem "select2-rails", '3.5.9.1'
gem 'jquery-ui-rails', '~> 5.0.0'
gem 'fullcalendar-rails'
gem 'google-api-client', '~> 0.7.1'
gem 'dropbox-sdk'
gem 'fog'
gem 'cancancan'
gem 'devise_invitable'
gem 'jquery-datetimepicker-rails', '~> 2.3.7.0'
gem "best_in_place"
gem 'jquery-validation-rails', '~> 1.12.0'
gem 'pg_search'

group :development do
  gem "disable_assets_logger", "~> 1.0.0"
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'awesome_print'       # Nicely formatted data structures in console, for example 'ap User.first'
end

group :development, :test, :staging do
  gem 'minitest', '~> 5.4.0'
  gem 'factory_girl_rails', '~> 4.4.1'                # Test data generator -- see spec/factories/factories.rb
  gem 'git-smart', '~> 0.1.9'                         # Allows 'git smart-pull' for less merge messes
  gem 'faker', '~> 1.2.0'                             # Easy way to add fake data: names, email addresses, etc.
end

group :test do
  gem 'shoulda-matchers', '~> 2.7.0', require: false  # Collection of testing matchers extracted from Shoulda http://thoughtbot.com/community
  gem 'rspec-rails', '~> 3.0.2'                       # https://www.relishapp.com/rspec/rspec-rails/docs/gettingstarted
  gem 'rspec-activemodel-mocks', '~> 1.0.1'           # RSpec test doubles for ActiveModel and ActiveRecord
  gem 'capybara', '~> 2.4.1'
  gem 'database_cleaner', '~> 1.3.0'                  # database_cleaner is not required, but highly recommended
  gem 'selenium-webdriver', '~> 2.43.0'
  gem 'capybara-firebug', '~> 2.0.0'
  gem 'cucumber-rails', '~> 1.4.0', :require => false  # Cucumber Generator and Runtime for Rails
  gem 'action_mailer_cache_delivery'
end

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug', '~> 2.0.0'
  # Access an IRB console on exceptions page and /console in development
  gem 'web-console', '~> 2.0.0.beta4'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.1.3'
end

group :production do
  gem 'rails_12factor'
end
