
require 'test_helper'

feature 'Pictures' do

  scenario 'as an authenticated user, new pictures I save go to my gallery' do
    login_user
    visit root_path
    # do some drawing
    # save drawing
    # drawing appears in gallery
  end

  scenario 'As a picture owner, I can delete my pictures' do
  end

  scenario "a non-owner user, I cannot delete other people's pictures" do
    visit galleries_path
    click_on "Galactus the World Devourer's pictures"
    # ???
    # Profit!
  end

  scenario "as an authenticated user, I can branch anybody's pictures" do
  end

  scenario "as an unauthenticated user, I am promted to login or register to branch other people's pictures" do
  end

end
