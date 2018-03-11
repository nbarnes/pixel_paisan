
source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '~> 4.2'

gem 'pg', '~> 0.15' # Rails does not yet support pg 1.0.0+ as of 1-24-18

gem 'autoprefixer-rails'
gem 'coffee-rails'
gem 'haml'
gem 'jquery-datatables-rails'
gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

gem 'unicorn'

gem 'chunky_png'
gem 'rmagick', require: 'rmagick'

gem 'devise' # authentication
gem 'figaro'
gem 'groupdate'
gem 'simple_form'

# Avoids JS precompilation problem per https://github.com/jejacks0n/teaspoon/issues/443
gem 'sprockets-rails', '~> 2.0'

group :production do
  gem 'rails_12factor' # for Heroku
end

group :test, :development do
  gem 'bullet'
  gem 'capybara-selenium'
  gem 'magic_lamp'
  gem 'minitest-rails-capybara'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'rails_best_practices'
  gem 'teaspoon-jasmine'
end

group :development do
  gem 'brakeman', require: false
  gem 'haml-lint', require: false
  gem 'letter_opener'
  gem 'rubocop', '~> 0.52', require: false
  gem 'spring'
end

group :test do
  gem 'chromedriver-helper'
  gem 'headhunter'
  gem 'minitest-reporters'
  gem 'simplecov'
end
