
require 'test_helper'

feature 'Colors' do

  scenario 'All colors from the palette are displayed in the editor palette', js: true do
    visit root_path
    palettes(:palette2).colors.each do |color|
      page.must_have_css("#color_button_r#{color['r']}g#{color['g']}b#{color['b']}")
    end
  end

  # ought to have a test here for spurious color loading onto the palette

  scenario 'I can add colors to one of my palettes using the editor', js: true do
    login_user
    visit root_path
    select("tony's palette")
    page.wont_have_css('#color_button_r111g222b73')
    click_on 'color_picker_opener'
    fill_in 'r_value_field', with: '111'
    fill_in 'g_value_field', with: '222'
    fill_in 'b_value_field', with: '73'
    find('#add_new_color_button').click
    page.must_have_css('#color_button_r111g222b73')
  end

  scenario 'Color adder widget not displayed when viewing or using palettes I do not own', js: true do
    login_user
    visit root_path
    page.wont_have_css('#color_picker_opener')
  end

end
