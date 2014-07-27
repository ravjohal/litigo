source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'devise'
gem 'pg'
gem 'pundit'
gem 'simple_form'
gem 'thin'
gem 'figaro'
gem "font-awesome-rails"
gem 'omniauth-google-oauth2', '~> 0.2.5'    # Allows oauth2 support for Google
gem "table-for", '~> 3.2.0'
gem 'will_paginate', '~> 3.0.7'
gem 'rest-client', '~> 1.7.1'               # Replacement for curl commands to grab contacts from google

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem "awesome_print"       # Nicely formatted data structures in console, for example "ap User.first"
  gem "git-smart", "~> 0.1.9"   # Allows "git smart-pull" for less merge messes
end

group :test do
  gem 'minitest', '~> 5.4.0'
  gem "shoulda-matchers", "~> 2.5.0"                  # Collection of testing matchers extracted from Shoulda http://thoughtbot.com/community
  gem "factory_girl_rails", "~> 4.3.0"                # Test data generator -- see spec/factories/factories.rb
  gem "capybara", "~> 2.2.1"
  gem "database_cleaner", "~> 1.2.0"                  # database_cleaner is not required, but highly recommended
  gem "selenium-webdriver", "~> 2.41.0"
  gem "capybara-firebug", '~> 2.0.0'
  gem "cucumber-rails", "~>1.4.0", :require => false  # Cucumber Generator and Runtime for Rails
end
group :production do
  gem 'rails_12factor'
end
  gem 'pry-debugger', group: [:development, :test]        # Pry navigation commands via debugger (formerly ruby-debug) https://github.com/nixme/pry-debugger
  gem "rspec-rails", group: [:development, :test]         # https://www.relishapp.com/rspec/rspec-rails/docs/gettingstarted
