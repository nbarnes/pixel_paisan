
require 'test_helper'

feature 'Pictures' do

  scenario 'as an authenticated user, new pictures I save go to my gallery', js: true do
    login_user
    visit root_path
    click_on 'Create New'
    accept_prompt with: 'My_new_picture' do
      click_on 'Change Name'
    end
    click_on 'Save Picture'
    find_by_id('picture_saved_pane').click
    click_on 'My Pictures'
    page.must_have_content 'My_new_picture'
  end

  scenario 'As a picture owner, I can delete my pictures' do
    login_user
    visit gallery_path(galleries(:tony_gallery).id)
    click_on 'tony_picture01'
    click_on 'Delete Image'
    page.wont_have_content 'tony_picture01'
  end

  scenario "a non-owner user, I cannot delete other people's pictures" do
    visit galleries_path
    click_on "Galactus the World Devourer's pictures"
    # ???
    # Profit!
    page.wont_have_content 'Delete'
  end

  scenario "as an authenticated user, I can branch anybody's pictures" do
  end

  scenario "as an unauthenticated user, I am promted to login or register to branch other people's pictures" do
  end

  scenario 'as a picture owner, I can change the name of a picture' do
    login_user
    visit pictures_path(pictures(:tony_picture01).id)
    click_on 'Edit in Painter'
    page.must_have_content 'tony_picture01'
    click_on 'Change Name'
    accept_prompt with: 'renamed_picture' do
      click_on 'Ok'
    end
    visit pictures_path(pictures(:tony_picture01).id)
    page.wont_have_content 'tony_picture01'
    page.must_have_content 'renamed_picture'
  end

end
