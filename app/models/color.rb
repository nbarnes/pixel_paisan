class Color < ActiveRecord::Base

  has_many :palette_colors
  has_many :palettes, :through => :palette_colors

  accepts_nested_attributes_for :palettes, :allow_destroy => :false

  validates :r, :g, :b, :a, presence: true

  validate :color_value_between_0_and_255, :value_between_0_and_1


  def color_value_between_0_and_255
    if r < 0 or r > 255
      errors.add(:value, 'color value must be between 0 and 255')
    end
  end

  def value_between_0_and_1
    if a < 0 or a > 1
      errors.add(:value, 'alpha value must be between 0 and 1')
    end
  end

end
