
require 'test_helper'

feature 'Users' do

  scenario 'existing account successfully logged in' do
    # Given an existing user
    visit editor_path
    click_on 'Login'
    fill_in 'Email', with: users(:galactus).email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    # Then I should receive a successful login message
    page.must_have_content 'Logout'
    page.must_have_content 'galactus@everywhere.com'
    page.wont_have_content 'Login'
    page.wont_have_content 'Invalid email or password.'
  end

  scenario 'create new account' do
    visit editor_path
    click_on 'Sign up'
    fill_in 'Email', with: 'srogers@usa.gov'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    find_button('Sign up').click
    # Then I should receive a successful login message
    page.must_have_content 'Logout'
    page.wont_have_content 'Login'
    page.wont_have_content 'Invalid email or password.'
  end

  scenario 'sign in and out' do
    # Given an existing user
    visit editor_path
    click_on 'Login'
    fill_in 'Email', with: users(:galactus).email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    # Then log out
    click_on 'Logout'
    page.must_have_content 'Signed out successfully.'
    page.wont_have_content 'Logout'
    page.wont_have_content users(:galactus).email
  end

end
