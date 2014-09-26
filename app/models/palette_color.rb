class PaletteColor < ActiveRecord::Base

  belongs_to :color
  belongs_to :palette

end
