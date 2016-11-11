
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'capybara/poltergeist'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  fixtures :all

  # Capybara.javascript_driver = :webkit

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, timeout: 180)
  end

  Capybara.javascript_driver = :poltergeist

  Capybara::Webkit.configure do |config|
    config.allow_url('http://fonts.googleapis.com/css?family=Molengo')
    config.allow_url('http://fonts.googleapis.com/css?family=Lekton')
  end

  def login_admin
    visit editor_path
    click_on 'Login'
    fill_in 'Email', with: users(:galactus).email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

  def login_user
    visit editor_path
    click_on 'Login'
    fill_in 'Email', with: users(:tony).email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

end
