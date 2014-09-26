class Palette < ActiveRecord::Base

  has_many :palette_colors
  has_many :colors, :through => :palette_colors

  accepts_nested_attributes_for :colors, :allow_destroy => :false

  validates :name, presence: true

end