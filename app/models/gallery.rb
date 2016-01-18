class Gallery < ActiveRecord::Base
  include ImageUnavailable

  belongs_to :user
  has_many :pictures

  validates :user, presence: true

  def thumbnail
		return pictures[0] ? pictures[0].current_version.thumbnail_png : image_unavailable_png
  end

end
