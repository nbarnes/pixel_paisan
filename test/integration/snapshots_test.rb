
require 'test_helper'

feature 'Snapshots' do

  scenario 'as an authenticated user, new snapshots I make go to their picture' do
  end

  scenario 'As a picture owner, I can delete a snapshot from a picture' do
  end

  scenario "a non-owner user, I cannot delete other people's snapshots" do
    visit galleries_path
    click_on "Galactus the World Devourer's pictures"
    page.wont_have_content 'Delete'
  end

  scenario "as an authenticated user, I can branch anybody's snapshots" do
    login_user
    visit galleries_path
    click_on "Galactus the World Devourer's pictures"
    # page.must_have_content 'Branch Picture'
  end

  scenario "as an unauthenticated user, I am promted to login or register to branch other people's snapshots" do
    visit galleries_path
    click_on "Galactus the World Devourer's pictures"
    # page.must_have_content 'Branch Picture'
  end

end
