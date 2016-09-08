
source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '~> 4.2'

gem 'pg'
gem 'groupdate'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'haml'
gem 'autoprefixer-rails'

gem 'unicorn'

gem 'jquery-rails'
gem 'jquery-datatables-rails'

gem 'chunky_png'
gem 'rmagick', require: 'RMagick'

gem 'devise' # authentication
gem 'figaro'
gem 'simple_form'

group :production do
  gem 'rails_12factor' # for Heroku
end

group :test, :development do
  gem 'capybara-webkit'
  gem 'minitest-rails-capybara'
  gem 'pry-rails'
  gem 'rails_best_practices'
  gem 'quiet_assets'
  gem 'bullet'
end

group :development do
  gem 'spring'
  gem 'brakeman', require: false
  gem 'letter_opener'
end

group :test do
  gem 'headhunter'
  gem 'simplecov'
  gem 'minitest-reporters'
end

# Use unicorn as the app server
# gem 'unicorn'
