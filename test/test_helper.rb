
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'selenium/webdriver'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  fixtures :all

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.register_driver :headless_chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless disable-gpu] }
    )

    Capybara::Selenium::Driver.new app,
                                   browser: :chrome,
                                   desired_capabilities: capabilities
  end

  Capybara.javascript_driver = :headless_chrome

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

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
