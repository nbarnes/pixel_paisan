class FrontPageController < ApplicationController

  def welcome
    @palettes = user_palettes
    @picture_id = nil
  end

end
