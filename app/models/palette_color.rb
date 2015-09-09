class PaletteColor < ActiveRecord::Base

  belongs_to :color
  belongs_to :palette

  def self.for(palette, color)
    return PaletteColor.find_by(palette_id: palette.id, color_id: color.id)
  end

end
