# rake test TEST=test/integration/galleries_test.rb

require 'test_helper'

feature 'Galleries' do

  scenario 'New user gets a gallery' do
    visit galleries_path
    page.wont_have_content "Steve Rogers' pictures"

    # create account
    visit root_path
    click_on 'Sign up'
    fill_in 'Email', with: 'srogers@usa.gov'
    fill_in 'Name', with: 'Steve Rogers'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    find_button('Sign up').click

    visit galleries_path
    page.must_have_content "Steve Rogers's pictures"
  end

  scenario 'Gallery shows all pictures for a user' do
    visit galleries_path
    click_on "Rocket Raccoon's pictures"

    page.must_have_content 'rocket_picture01'
    page.must_have_content 'rocket_picture02'
    page.wont_have_content 'gal_picture01'
  end

  scenario 'Gallery adds new pictures', js: true do
    login_user
    visit editor_path
    find('#tool_bar_file_element').click
    find('#new_picture_option').click
    find('#tool_bar_file_element').click
    find('#save_picture_option').click
    sleep 5
    page.execute_script('$.modal.close();')
    click_on 'My Pictures'
    page.must_have_content 'new_picture'
  end

end
