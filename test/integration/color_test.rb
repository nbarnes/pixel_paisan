require 'test_helper'

feature 'Colors' do

  scenario 'All colors from the palette are displayed in the editor palette', js: true do
    visit root_path
    default_color_palette = palettes(:palette2)
    default_color_palette.colors.each do |color|
      page.must_have_css("#color_button_r#{color.r}g#{color.g}b#{color.b}")
    end
  end

  # ought to have a test here for spurious color loading onto the palette

  scenario 'I can add colors to one of my palettes using the editor', js: true do
    login_user
    visit root_path
    select("tony's palette")
    page.must_have_css('.sp-replacer.sp-light')
  end

  scenario 'Color adder widget not displayed when viewing or using palettes I do not own', js: true do
    visit root_path
    page.wont_have_css('.sp-replacer.sp-light')
  end

end
