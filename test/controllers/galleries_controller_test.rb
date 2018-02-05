require 'test_helper'

class GalleriesControllerTest < ActionController::TestCase
  setup do
    @gallery = galleries(:gal_gallery)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:galleries).length, Gallery.all.length
  end

  test "should get new" do
    get :show, id: @gallery
    assert_response :success
    assert_equal assigns(:gallery), @gallery
  end

end
