source 'https://rubygems.org'
ruby '2.1.3'
gem 'rails', '~> 4.2.0.beta2'
gem 'ffi', '~> 1.9.5'
#Rack-based asset packaging system
gem 'sprockets-rails', '~> 3.0.0.beta1'
gem 'sass-rails', :git => 'https://github.com/rails/sass-rails.git', :branch => 'master'
gem 'uglifier', '~> 2.5.3'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '~> 3.1.2'
gem 'turbolinks', '~> 2.4.0'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'bootstrap-sass', '~> 3.2.0.2'
gem 'autoprefixer-rails', '~> 3.1.2'
gem 'devise', '~> 3.4.0'
gem 'pg', '~> 0.17.1'
gem 'pundit', '~> 0.3.0'
gem 'simple_form', '~> 3.0.2'
gem 'hopscotch-rails', '~> 0.1.2.1'
gem 'unicorn', '~> 4.8.3'
gem 'carrierwave', '~> 0.10.0'
gem 'figaro', '~> 1.0.0'
gem 'font-awesome-rails', '~> 4.2.0.0'
gem 'omniauth-google-oauth2', '~> 0.2.5'    # Allows oauth2 support for Google
gem 'will_paginate', '~> 3.0.7'
gem 'rest-client', '~> 1.7.1'               # Replacement for curl commands to grab contacts from google
gem 'active_link_to', '~> 1.0.2'
gem 'jquery-datatables-rails', '~> 2.2.3'
gem "select2-rails", '3.5.9.1'
gem 'jquery-ui-rails', '~> 5.0.0'
gem 'fullcalendar-rails', '~> 1.6.4.0'
gem 'google-api-client', '~> 0.7.1'
gem 'dropbox-sdk', '~> 1.6.4'
gem 'fog', '~> 1.24.0'
gem 'cancancan', '~> 1.9.2'
gem 'devise_invitable', '~> 1.3.6'
gem 'jquery-datetimepicker-rails', '~> 2.3.7.0'
gem 'best_in_place', '~> 3.0.0'
gem 'jquery-validation-rails', '~> 1.12.0'
gem 'pg_search', '~> 0.7.8'
gem 'rails_best_practices', '~> 1.15.4'                   #https://github.com/railsbp/rails_best_practices
gem 'brakeman', '~> 2.6.3'

group :development do
  gem "disable_assets_logger", "~> 1.0.0"
  gem 'better_errors', '~> 2.0.0'
  gem 'binding_of_caller', '~> 0.7.2', :platforms=>[:mri_21]
  gem 'hub', '~> 1.12.2', :require=>nil
  gem 'quiet_assets', '~> 1.0.3'
  gem 'rails_layout', '~> 1.0.23'
  gem 'awesome_print', '~> 1.2.0'       # Nicely formatted data structures in console, for example 'ap User.first'
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
  gem 'action_mailer_cache_delivery', '~> 0.3.7'
  gem 'simplecov', '~> 0.9.1', :require => false                   # https://github.com/colszowka/simplecov
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
  gem 'rails_12factor', '~> 0.0.3'
end
