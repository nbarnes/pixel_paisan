require "test_helper"

feature "As a visitor, I want to sign into my existing account." do

  scenario "existing account successfully logged in" do
    # Given an existing user
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: users(:galactus).email
    fill_in 'Password', with: "password"
    click_on 'Log in'
    # Then I should receive a successful login message
    page.must_have_content "Logout"
    page.wont_have_content "Login"
    page.wont_have_content "Invalid email or password."
  end

  scenario "create new account" do
    visit root_path
    click_on 'Sign up'
    fill_in 'Email', with: 'srogers@usa.gov'
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    find_button('Sign up').click
    # Then I should receive a successful login message
    page.must_have_content "Logout"
    page.wont_have_content "Login"
    page.wont_have_content "Invalid email or password."
  end

end
