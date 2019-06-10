# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0.rc1'

# Use postgresql as the database for Active Record
# https://bitbucket.org/ged/ruby-pg/wiki/Home
gem 'pg', '1.1.4'

# A set of common locale data and translations to internationalize and / or localize your Rails applications.
gem 'rails-i18n', '5.1.3'

# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Shim to load environment variables from .env into ENV in development.
  # https://github.com/bkeepers/dotenv
  gem 'dotenv-rails', '2.7.2'

  # Testing framework for Rails 3.x, 4.x and 5.x.
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.7'

  # A library for setting up Ruby objects as test data.
  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails', '~> 5.0'

  # help to kill N+1 queries and unused eager loading
  # https://github.com/flyerhzm/bullet
  gem 'bullet', '~> 6.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # A fully configurable and extendable Git hook manager
  # https://github.com/brigade/overcommit
  gem 'overcommit', '~> 0.48.1'

  # A Ruby static code analyzer and formatter, based on the community Ruby style guide.
  # https://github.com/rubocop-hq/rubocop
  gem 'rubocop', '~> 0.71', require: false
end

group :test do
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners that test common Rails functionality.
  gem 'shoulda-matchers', '~> 4.0'

  # Code coverage for Ruby 1.9+
  gem 'simplecov', '~> 0.16.1', require: false

  gem 'rails-controller-testing', '~> 1.0'

  # Strategies for cleaning databases in Ruby, used to ensure a clean state for testing.
  gem 'database_cleaner', '~> 1.7.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
