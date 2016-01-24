class FrontPageController < ApplicationController

  def welcome
    @palettes = palettes
  end

end
