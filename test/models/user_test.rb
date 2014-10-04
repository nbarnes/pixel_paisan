require "test_helper"

class UserTest < ActiveSupport::TestCase

  def user
    @user ||= User.new
  end

  def test_valid
    assert user.valid?
  end

end
