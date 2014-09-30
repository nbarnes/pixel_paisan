class FrontPageController < ApplicationController

  def welcome
    @palettes = Palette.all
  end

end
