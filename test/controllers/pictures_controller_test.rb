require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  setup do
    @picture = pictures(:gal_picture01)
  end

  test "show" do
    get :show, id: @picture
    assert_response :success
    assert_equal assigns(:picture), @picture
  end

  test "destroy without owning picture" do
    delete :destroy, id: @picture
    assert Picture.exists? @picture.id
    assert_response :unauthorized
  end

  test "destroy while owning picture" do
    sign_in users(:galactus)
    delete :destroy, id: @picture
    assert_not Picture.exists? @picture.id
    assert_redirected_to gallery_path(@picture.gallery.id)
  end

  test "create" do
    sign_in users(:galactus)

    post :create,
      pixels: valid_pixels,
      name: 'new_picture',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20

    assert_response :success
  end

  test "create with invalid characters in name" do
    sign_in users(:galactus)

    post :create,
      pixels: valid_pixels,
      name: 'new pic^^tu re',
      palette_id: palettes(:gals_default_palette).id,
      cell_size: 20

    assert_response :success
  end

  # test "edit" do
  #   get :show, id: @picture
  #   assert_response :success
  # end

  # test "update" do
  #   get :edit, id: @picture
  #   assert_response :success
  # end

  # test "update with canvas size change" do
  #   get :edit, id: @picture
  #   assert_response :success
  # end

end

def valid_pixels
  return [
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ],
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ],
    [
      {
        r: 100,
        g: 150,
        b: 200,
        a: 1
      },
      {
        r: 200,
        g: 75,
        b: 50,
        a: 1
      },
      {
        r: 80,
        g: 42,
        b: 49,
        a: 125
      }
    ]
  ]

end
