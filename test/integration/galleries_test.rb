
require 'test_helper'

feature 'Galleries' do

  scenario 'New user gets a gallery' do
    visit galleries_path
    page.wont_have_content "Steve Rogers's pictures"

    # create account
    visit root_path
    click_on 'Sign up'
    fill_in 'user_name', with: 'Steve Rogers'
    fill_in 'Email', with: 'srogers@avengers.org'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    find_button('Sign up').click

    visit galleries_path
    page.must_have_content "Steve Rogers's pictures"
  end

  scenario 'Gallery shows all pictures for a user' do
    # having trouble loading pictures&snapshots as fixtures
  end

  scenario 'Gallery adds new pictures' do
    # having trouble loading pictures&snapshots as fixtures
  end

end
