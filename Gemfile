
source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.1.8'

gem 'pg'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'haml'
gem 'autoprefixer-rails'

gem 'unicorn'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'chunky_png'
gem 'rmagick', require: 'RMagick'
gem 'fog'
gem 'asset_sync'
gem 'sidekiq'

# Sinatra for the sidekiq web monitor
gem 'sinatra', require: nil

gem 'devise' # authentication
gem 'figaro'
gem 'simple_form'

# gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'rails_12factor' # for Heroku

group :test, :development do
  gem 'jasmine-rails'
  gem 'jasmine-jquery-rails'
  gem 'capybara-webkit'
  gem 'minitest-rails-capybara'
  gem 'pry-rails'
  gem 'rails_best_practices'
end

group :development do
  gem 'spring'
  gem 'brakeman', require: false
end

group :test do
  gem 'headhunter'
  gem 'simplecov'
  gem 'minitest-reporters'
end

# Use unicorn as the app server
# gem 'unicorn'
