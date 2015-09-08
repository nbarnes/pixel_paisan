require 'test_helper'

feature 'Palettes' do

  scenario 'Logged in user can create a palette' do
    login_user
    visit palettes_path
    click_on 'New Palette'
  end

  scenario 'Unauthenticated user cannot create a palette' do
    visit palettes_path
    page.wont_have_content 'New Palette'
  end

  scenario 'As a palette owner, I can create new colors on the palette using the site view' do
    login_user
    visit palettes_path
    click_on "tony's palette"
    click_on "Add New Color"
    fill_in 'R', with: '25'
    fill_in 'G', with: '150'
    fill_in 'B', with: '120'
    click_on 'Create Color'
    page.must_have_content '25, 150, 120'
    page.must_have_content 'Remove Color'
  end

  scenario 'As a palette owner, I can delete my palettes' do
  end

  scenario 'As a palette owner, I can remove colors from my palettes' do
  end

  scenario 'As a non-owner, I cannot delete a palette' do
  end

  scenario 'As a non-owner, I cannot remove a color from a palette' do
  end



end
