source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks' # Don't need when using AngularJS
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Server
gem 'puma'
gem 'active_model_serializers'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Database
gem 'pg'
gem 'pg_search'

# Assets
gem 'slim-rails'

# NOTE: angular-rails-templates not yet compatible with sprockets >= 3.0
# https://github.com/pitr/angular-rails-templates/issues/93
gem 'angular-rails-templates'
gem 'sprockets', '~> 2.12.4'
# Forked version of angular-rails-templates that works with sprockets >= 3.0
# gem 'angular-rails4-templates'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'

  # `rails g rspec:install`
  gem 'rspec-rails'

  # `require 'should_not/rspec'` in rails_helper.rb
  gem 'should_not'

  gem 'factory_girl_rails'
  gem 'faker'

  # `shoulda_helper.rb` and `require 'shoulda_helper'` in rails_helper.rb
  gem 'shoulda-matchers', '~> 3.0'

  # `rails generate teaspoon:install --coffee`
  gem 'teaspoon-jasmine'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Error backtraces and interactive console
  gem 'better_errors'
  gem 'binding_of_caller'

  # Remove asset output from server logs
  gem 'quiet_assets'

  gem 'rubocop', require: false

  # `guard` to watch files and run tasks
  gem 'guard', '>= 2.2.2', require: false

  # guard notifications
  gem 'terminal-notifier-guard'

  # Livereload: https://mattbrictson.com/lightning-fast-sass-reloading-in-rails
  # Add `config.middleware.insert_after(ActionDispatch::Static, Rack::LiveReload)` to `config/environments/development.rb`
  # `guard init livereload`
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'rb-fsevent',       require: false

  gem 'phantomjs'

  # `guard init bundler`
  gem 'guard-bundler', require: false

  # `guard init rspec`
  gem 'guard-rspec', require: false

  # `guard init rubocop`
  gem 'guard-rubocop', require: false

  # `guard init teaspoon`
  gem 'guard-teaspoon', require: false
end

group :production do
  gem 'asset_sync'  
  gem 'rails_12factor'
  gem 'rack-timeout'
end
