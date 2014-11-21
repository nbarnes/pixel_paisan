require "test_helper"

class GalleriesControllerTest < ActionController::TestCase

  def gallery
    @gallery ||= galleries :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:galleries)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Gallery.count') do
      post :create, gallery: {  }
    end

    assert_redirected_to gallery_path(assigns(:gallery))
  end

  def test_show
    get :show, id: gallery
    assert_response :success
  end

  def test_edit
    get :edit, id: gallery
    assert_response :success
  end

  def test_update
    put :update, id: gallery, gallery: {  }
    assert_redirected_to gallery_path(assigns(:gallery))
  end

  def test_destroy
    assert_difference('Gallery.count', -1) do
      delete :destroy, id: gallery
    end

    assert_redirected_to galleries_path
  end
end
