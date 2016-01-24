class FrontPageController < ApplicationController

  def welcome
    @palettes = palettes
    @picture_id = nil
  end

end
