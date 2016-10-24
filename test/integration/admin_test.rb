
require 'test_helper'

feature 'Admin' do

  scenario 'Users index displays correctly', js: true do
    login_admin
    visit admin_users_path
    page.must_have_content 'Galactus the World Devourer'
    page.must_have_content 'Rocket Raccoon'
    page.must_have_content 'Tony Stark'
  end

  scenario 'Users show displays correctly' do
    login_admin
    visit admin_user_path users(:tony).id
    page.must_have_content 'iron_man@stark.com'
    page.must_have_content Time.now.strftime('%m/%d/%Y')
    page.must_have_css '.picture_thumbnail'
  end

  scenario 'Activities index displays correctly' do
    login_admin
    visit admin_activities_path
    page.must_have_content "#{Time.now.strftime('%A')} the #{Time.now.day.ordinalize}"
  end

  scenario 'Activities show displays correctly' do
    login_admin
    visit admin_activity_path 'day', Time.now
    page.must_have_content "#{Time.now.strftime('%A')} the #{Time.now.day.ordinalize}"
    page.must_have_content 'Galactus the World Devourer'
    page.must_have_content 'Rocket Raccoon'
    page.must_have_content 'Tony Stark'
    page.must_have_content 'gal_picture01'
    page.must_have_content 'tony_picture01'
    page.must_have_content 'rocket_picture01'
  end

end
