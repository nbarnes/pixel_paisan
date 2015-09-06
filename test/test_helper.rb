
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'

class ActiveSupport
  class TestCase
    fixtures :all

    def login_admin
      visit root_path
      click_on 'Login'
      fill_in 'Email', with: users(:galactus).email
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end

    def login_user
      visit root_path
      click_on 'Login'
      fill_in 'Email', with: users(:tony).email
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end
  end
end
