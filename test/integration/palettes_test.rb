
require 'test_helper'

feature 'Palettes' do

  scenario 'Logged in user can create a palette' do
    login_user
    visit user_palettes_path(users(:tony).id)
    page.wont_have_content 'Steel Palette'
    click_on 'New Palette'
    fill_in 'Name', with: 'Steel Palette'
    click_on 'Create Palette'
    page.must_have_content 'Steel Palette'
  end

  scenario 'As a palette owner, I can create new colors on the palette using the site view' do
    login_user
    visit user_palettes_path(users(:tony).id)
    click_on "tony's palette"
    click_on 'Add New Color'
    fill_in 'R:', with: '25'
    fill_in 'G:', with: '150'
    fill_in 'B:', with: '120'
    click_on 'Create Color'
    page.must_have_content '25,150,120'
    page.must_have_content 'Remove Color'
  end

  scenario 'As a palette owner, I can delete my palettes' do
    login_user
    visit user_palettes_path(users(:tony).id)
    click_on "tony's palette"
    click_on 'Delete Palette'
    page.must_have_content "Palette 'tony's palette' was deleted."
    page.wont_have_link "tony's palette"
  end

  scenario 'As a palette owner, I can remove colors from my palettes', js: true do
    login_user
    visit user_palettes_path(users(:tony).id)
    click_on "tony's palette"
    find('div div div', text: '128,0,0').find(:xpath, '..').click_on 'Remove Color'
    page.evaluate_script('window.confirm = function() { return true; }')
    page.wont_have_content '128,128,255'
  end

  scenario 'As a non-owner, I cannot delete a palette' do
    login_user
    visit user_palettes_path(users(:rocket).id)
    click_on "rocket's first palette"
    page.wont_have_content 'Delete Palette'
  end

  scenario 'As a non-owner, I cannot remove a color from a palette' do
    login_user
    visit user_palettes_path(users(:galactus).id)
    click_on "galactus' palette"
    page.wont_have_content 'Remove Color'
  end

  scenario 'As a site user, I can load any of the default palettes and my own owned ones', js: true do
    login_user
    visit root_path
    page.must_have_css('option#tonys_palette')
    page.must_have_css('option#Gals_default_palette')
    page.wont_have_css('option#galactus_palette')
    page.wont_have_css('option#rockets_palette')
  end

end
