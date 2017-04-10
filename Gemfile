
source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '~> 4.2'

gem 'pg'

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

group :production do
  gem 'rails_12factor' # for Heroku
end

group :test, :development do
  gem 'bullet'
  gem 'capybara-webkit'
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
  gem 'rubocop', require: false
  gem 'spring'
end

group :test do
  gem 'headhunter'
  gem 'minitest-reporters'
  gem 'poltergeist'
  gem 'simplecov'
end
