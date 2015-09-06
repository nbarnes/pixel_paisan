require 'test_helper'

feature 'As a palette owner, I want to be able to edit my own palettes' do

  scenario 'existing account successfully logged in' do
    login_galactus
    visit palettes_path
    click_on "galactus' palette"
    page.must_have_content 'Add New Color'
    page.must_have_content 'Delete Palette'
  end

  scenario "As a non-owner, I shouldn't be able to edit other people's palettes" do
    login_tony
    visit palettes_path
    click_on "galactus' palette"
    page.wont_have_content 'Add New Color'
    page.wont_have_content 'Delete Palette'
  end

end
