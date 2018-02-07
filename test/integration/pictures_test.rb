
require 'test_helper'

feature 'Pictures' do

  scenario 'as an authenticated user, new pictures I save go to my gallery', js: true do
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

  scenario 'As a picture owner, I can delete my pictures' do
    login_user
    visit gallery_path(galleries(:tony_gallery).id)
    click_on 'tony_picture03'
    click_on 'Delete Picture'
    page.wont_have_content 'tony_picture03'
  end

  scenario "a non-owner user, I cannot delete other people's pictures" do
    visit galleries_path
    click_on "Galactus the World Devourer's pictures"
    page.wont_have_content 'Delete'
  end

  scenario "as an authenticated user, I can branch anybody's pictures" do
  end

  scenario "as an unauthenticated user, I am promted to login or register to branch other people's pictures" do
  end

  # I haven't been able to make these tests work on Travis CI. They seem to be having some sort of
  # JS script failure that I can't diagnose.
  # http://stackoverflow.com/questions/40098319/rails-javascript-test-fails-on-travis-ci-works-locally

  scenario 'as a picture owner, I can change the name of a picture via the editor', js: true do
    if ENV['TRAVIS'] != 'true'
      login_user
      visit picture_path(pictures(:tony_picture01).id)
      page.must_have_content 'tony_picture01'
      click_on 'Edit Picture In Painter'
      page.must_have_content 'tony_picture01'

      find('#tool_bar_file_element').click
      accept_prompt with: 'renamed_picture' do
        find('#rename_picture_option').click
      end
      find('#tool_bar_file_element').click
      find('#save_picture_option').click

      page.wont_have_content 'tony_picture01'
      page.must_have_content 'renamed_picture'
      visit picture_path(pictures(:tony_picture01).id)
      page.wont_have_content 'tony_picture01'
      page.must_have_content 'renamed_picture'
    end
  end

  scenario 'as a picture owner, I can change the name of a picture via picture display', js: true do
    if ENV['TRAVIS'] != 'true'
      login_user
      visit show_picture_path(pictures(:tony_picture02).id)
      page.must_have_content 'tony_picture02'
      accept_prompt with: 'renamed_picture02' do
        click_on 'Change Name'
      end
      page.wont_have_content 'tony_picture02'
      page.must_have_content 'renamed_picture02'
      visit show_picture_path(pictures(:tony_picture02).id)
      page.wont_have_content 'tony_picture02'
      page.must_have_content 'renamed_picture02'
    end
  end

  scenario 'associated palettes are loaded in the editor when a picture is', js: true do
    login_user
    visit edit_picture_path(pictures(:tony_picture01).id)
    sleep 20
    find('#palette_selector').value.must_equal palettes(:tonys_palette).id.to_s
  end

end
