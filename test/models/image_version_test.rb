require "test_helper"

class ImageVersionTest < ActiveSupport::TestCase

  def image_version
    @image_version ||= ImageVersion.new
  end

  def test_valid
    assert image_version.valid?
  end

end
